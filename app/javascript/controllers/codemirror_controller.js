import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static targets = ["editor", "output"]

  connect() {
    this.editor = CodeMirror.fromTextArea(this.editorTarget, {
      mode: "ruby",
      lineNumbers: true,
      indentUnit: 2,
      tabSize: 2,
      lineWrapping: true,
      autofocus: true
    })
    this.codeEditor = document.querySelector(`#code-editor`);
    const methodTemplate = this.codeEditor.dataset.methodTemplate.replaceAll("\\n", "\n");
    this.editor.setValue(methodTemplate);
    this.roomId = this.codeEditor.dataset.roomId;
    this.challengeId = this.codeEditor.dataset.challengeId;
    this.setSize("500px")
    this.editor.on("change", () => this.syncContent())

    this.subscription = createConsumer()
      .subscriptions.create(
        { channel: "CollaborationChannel", room: this.roomId },
        { received: (data) => this.handleReceived(data) }
      )
  }

  disconnect() {
    this.subscription.unsubscribe()
  }

  setSize(height) {
    this.editor.getWrapperElement().style.height = height
  }

  get code() {
    return this.editor.getValue()
  }

  async run() {
    try {
      const resp = await fetch("/evaluate_code", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ code: this.code, id: this.challengeId })
      })
      if (!resp.ok) throw new Error(resp.statusText)
      const result = await resp.json()
      this.renderResult(result)
      this.subscription.send({ type: "output", output: this.outputTarget.textContent })
    } catch (err) {
      this.renderError(err)
    }
  }

  syncContent() {
    this.subscription.send({ content: this.code })
  }

  handleReceived(data) {
    if (data.type === "output") {
      this.outputTarget.textContent = data.output
    } else if (data.content !== this.code) {
      this.editor.setValue(data.content)
    }
  }

  renderResult({ error, output }) {
    if (error) return this.renderError(new Error(error))

    const lines = Object.entries(output).map(
      ([input, { expected, actual, passed }]) =>
        `Test case: ${input}\nExpected: ${expected}\nActual: ${actual}\nPassed: ${passed ? "✅" : "❌"}\n`
    ).join("\n")
    this.outputTarget.textContent = lines || "No output"
  }

  renderError(err) {
    console.error("Code eval error:", err)
    this.outputTarget.textContent = `Error: ${err.message}`
    this.subscription.send({ type: "output", output: this.outputTarget.textContent })
  }
}
