import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static targets = ["editor", "opponentEditor", "output", "runBtn", "myScore", "opponentScore", "opponentStatus"]
  static values  = { gameId: String, currentUserId: Number, challengeId: String, roundId: String }

  connect() {
    const codeEditorEl = document.getElementById("code-editor")

    if (codeEditorEl) {
      const methodTemplate = codeEditorEl.dataset.methodTemplate?.replaceAll("\\n", "\n") || ""
      this.editor = CodeMirror.fromTextArea(this.editorTarget, {
        mode: "ruby",
        lineNumbers: true,
        indentUnit: 2,
        tabSize: 2,
        lineWrapping: true,
        autofocus: true
      })
      this.editor.setValue(methodTemplate)
      this.editor.getWrapperElement().style.height = "360px"
      this.editor.on("change", () => this._debouncedBroadcast())
    }

    if (this.hasOpponentEditorTarget) {
      this.opponentEditor = CodeMirror.fromTextArea(this.opponentEditorTarget, {
        mode: "ruby",
        lineNumbers: true,
        indentUnit: 2,
        tabSize: 2,
        lineWrapping: true,
        readOnly: true,
        autofocus: false
      })
      this.opponentEditor.setValue("")
      this.opponentEditor.getWrapperElement().style.height = "200px"
      this.opponentEditor.getWrapperElement().style.opacity = "0.6"
    }

    this._broadcastTimer = null

    this.subscription = createConsumer().subscriptions.create(
      { channel: "GameChannel", game_id: this.gameIdValue },
      { received: (data) => this.handleBroadcast(data) }
    )
  }

  disconnect() {
    this.subscription?.unsubscribe()
  }

  get code() {
    return this.editor?.getValue() || ""
  }

  get csrfToken() {
    return document.querySelector('meta[name="csrf-token"]')?.content
  }

  async run() {
    if (!this.editor) return
    this.runBtnTarget.textContent = "Running…"
    this.runBtnTarget.disabled = true

    try {
      const resp = await fetch("/evaluate_code", {
        method: "POST",
        headers: { "Content-Type": "application/json", "X-CSRF-Token": this.csrfToken },
        body: JSON.stringify({ code: this.code, id: this.challengeIdValue, game_id: this.gameIdValue })
      })
      const result = await resp.json()
      this.renderResult(result)

      const allPassed = result.output && Object.values(result.output).every(r => r.passed)
      if (allPassed && !result.error) this.signalRoundWon()
    } catch (err) {
      this.outputTarget.textContent = `Error: ${err.message}`
    } finally {
      this.runBtnTarget.textContent = "Run Tests ▶"
      this.runBtnTarget.disabled = false
    }
  }

  async signalRoundWon() {
    await fetch(`/games/${this.gameIdValue}/round_won`, {
      method: "POST",
      headers: { "Content-Type": "application/json", "X-CSRF-Token": this.csrfToken },
      body: JSON.stringify({ round_id: this.roundIdValue, code: this.code })
    })
  }

  _debouncedBroadcast() {
    clearTimeout(this._broadcastTimer)
    this._broadcastTimer = setTimeout(() => this.broadcastCode(), 400)
  }

  async broadcastCode() {
    await fetch(`/games/${this.gameIdValue}/broadcast_code`, {
      method: "POST",
      headers: { "Content-Type": "application/json", "X-CSRF-Token": this.csrfToken },
      body: JSON.stringify({ code: this.code })
    })
  }

  handleBroadcast(data) {
    if (data.type === "code_update") {
      if (data.user_id !== this.currentUserIdValue && this.opponentEditor) {
        this.opponentEditor.setValue(data.code || "")
        if (this.hasOpponentStatusTarget) {
          this.opponentStatusTarget.textContent = `${data.user_name || "Opponent"} is coding…`
        }
      }
    } else if (data.type === "game_started") {
      window.location.reload()
    } else if (data.type === "game_declined") {
      window.location.href = "/"
    } else if (data.type === "round_completed") {
      if (data.winner_id === this.currentUserIdValue) {
        if (this.hasMyScoreTarget) this.myScoreTarget.textContent = parseInt(this.myScoreTarget.textContent) + 1
      } else {
        if (this.hasOpponentScoreTarget) this.opponentScoreTarget.textContent = parseInt(this.opponentScoreTarget.textContent) + 1
      }
      if (data.next_round_number) {
        this.showRoundInterstitial(data.round_number, data.winner_name)
      }
    } else if (data.type === "game_completed") {
      this.showGameResult(data.winner_id, data.winner_name)
    }
  }

  showRoundInterstitial(roundNumber, winnerName) {
    const banner = document.getElementById("game-banner")
    if (!banner) return
    banner.textContent = `Round ${roundNumber} complete — ${winnerName} won`
    banner.style.color = "var(--ck-ink)"
    banner.classList.remove("hidden")
    banner.scrollIntoView({ behavior: "smooth" })
    setTimeout(() => window.location.reload(), 2000)
  }

  showGameResult(winnerId, winnerName) {
    const banner = document.getElementById("game-banner")
    if (!banner) return
    if (winnerId === this.currentUserIdValue) {
      banner.textContent = "🏆 You won the game!"
      banner.style.color = "#a6d6ff"
    } else {
      banner.textContent = `${winnerName} won the game.`
      banner.style.color = "var(--ck-muted)"
    }
    banner.classList.remove("hidden")
    banner.scrollIntoView({ behavior: "smooth" })
    setTimeout(() => window.location.reload(), 3000)
  }

  renderResult({ error, output }) {
    if (error) {
      this.outputTarget.textContent = `Error: ${error}`
      return
    }
    const lines = Object.entries(output).map(([input, { expected, actual, passed }]) =>
      `Test: ${input}\nExpected: ${expected}\nActual:   ${actual}\n${passed ? "✅ Passed" : "❌ Failed"}`
    ).join("\n\n")
    this.outputTarget.textContent = lines || "No output"
  }

  async hint() {
    this.outputTarget.textContent = "Fetching hint…"
    try {
      const resp = await fetch("/hints", {
        method: "POST",
        headers: { "Content-Type": "application/json", "X-CSRF-Token": this.csrfToken },
        body: JSON.stringify({ challenge_id: this.challengeIdValue, code: this.code })
      })
      const result = await resp.json()
      this.outputTarget.textContent = result.hint || result.error || "No hint available."
    } catch (err) {
      this.outputTarget.textContent = `Error fetching hint: ${err.message}`
    }
  }
}
