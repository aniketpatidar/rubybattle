import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static targets = ['submit', 'testResults', 'editor']

  connect() {
    this.setupReadinessCheck()
    this.setupInitialization()
  }

  setupInitialization() {
    const initializeCodeMirror = () => {
      const textarea = document.querySelector('textarea[data-battle-target="editor"]')
      
      if (textarea) {
        try {
          if (!window.battleEditor) {
            window.battleEditor = CodeMirror.fromTextArea(textarea, {
              mode: 'ruby',
              theme: 'monokai',
              lineNumbers: true,
              tabSize: 2,
              indentUnit: 2,
              autofocus: true
            })
          }
        } catch (error) {
          console.error('Failed to initialize CodeMirror:', error)
          setTimeout(initializeCodeMirror, 500)
        }
      } else {
        setTimeout(initializeCodeMirror, 500)
      }
    }

    initializeCodeMirror()

    const observer = new MutationObserver((mutations) => {
      for (const mutation of mutations) {
        if (mutation.type === 'childList') {
          initializeCodeMirror()
        }
      }
    })

    observer.observe(document.body, {
      childList: true,
      subtree: true
    })
  }

  setupReadinessCheck() {
    this.disableEditorAndSubmit()
    this.cable = createConsumer()
    const roomCode = window.location.pathname.split('/').pop()

    this.subscription = this.cable.subscriptions.create(
      { channel: 'RoomChannel', room_code: roomCode },
      {
        connected: () => {
          this.subscription.perform('check_readiness')
        },
        received: (data) => {
          if (data.readiness_update) {
            this.handleReadinessUpdate(data.readiness_update)
          }

          if (data.room_status) {
            this.handleRoomStatusUpdate(data)
          }

          if (data.battle_ended) {
            this.handleBattleEnd(data)
          }
        },
        disconnected: () => {
          this.handleDisconnection()
        }
      }
    )
  }

  handleReadinessUpdate(readinessData) {
    console.group('🏁 Readiness Update Received')
    console.log('Full Readiness Data:', JSON.stringify(readinessData, null, 2))
    
    const readinessUpdate = readinessData.readiness_update || {}

    try {
      if (readinessData.participants) {
        this.updateParticipantsUI(readinessData.participants)
      }
      this.handleRoomStatus(readinessData)

      const canStart = this.canStartBattle(readinessData)
      console.log('Battle Can Start:', canStart)

      if (canStart) {
        this.initializeBattleStart(readinessData)
      }
    } catch (error) {
      console.error('Error Details:', {
        name: error.name,
        message: error.message,
        stack: error.stack
      })
    }

    console.groupEnd()
  }

  canStartBattle(data) {
    const readinessUpdate = data.readiness_update || {}
    const bothPlayersReady = 
      readinessUpdate.player1_ready && 
      readinessUpdate.player2_ready
    const participantsReady = 
      data.participants?.every(p => p.ready) && 
      data.participants_count === 2
    const roomReady = data.room_status === 'ready'
    const canStart = bothPlayersReady && participantsReady && roomReady
    return canStart
  }

  updateParticipantsUI(participants) {
    let participantsContainer = document.getElementById('participants-container')
    if (!participantsContainer) {
      participantsContainer = document.createElement('div')
      participantsContainer.id = 'participants-container'
      document.body.appendChild(participantsContainer)
    }

    participants.forEach(participant => {
      let playerElement = document.querySelector(`[data-user-id="${participant.user_id}"]`)
      
      if (!playerElement) {
        playerElement = document.createElement('div')
        playerElement.classList.add('participant')
        playerElement.dataset.userId = participant.user_id
        playerElement.dataset.username = participant.slug

        const usernameElement = document.createElement('span')
        usernameElement.classList.add('participant-username')
        usernameElement.textContent = participant.slug

        const statusElement = document.createElement('span')
        statusElement.classList.add('participant-status')
        
        playerElement.appendChild(usernameElement)
        playerElement.appendChild(statusElement)
        participantsContainer.appendChild(playerElement)
      }

      playerElement.classList.toggle('player-ready', participant.ready === true)
      playerElement.classList.toggle('player-not-ready', participant.ready !== true)

      const usernameElement = playerElement.querySelector('.participant-username')
      if (usernameElement) {
        usernameElement.textContent = participant.slug
      }

      const statusElement = playerElement.querySelector('.participant-status')
      if (statusElement) {
        statusElement.textContent = participant.subscription_status
        statusElement.className = `participant-status status-${participant.subscription_status.toLowerCase()}`
      }
    })

    console.groupEnd()
  }

  initializeBattleStart(data) {
    console.group('🚀 Battle Start Initialization')
    console.log('Battle Start Data:', JSON.stringify(data, null, 2))

    const requiredElements = {
      'waiting-message': () => {
        let element = document.getElementById('waiting-message')
        if (!element) {
          element = document.createElement('div')
          element.id = 'waiting-message'
          element.classList.add('hidden')
          document.body.appendChild(element)
        }
        return element
      },
      'battle-interface': () => {
        let element = document.getElementById('battle-interface')
        if (!element) {
          element = document.createElement('div')
          element.id = 'battle-interface'
          element.classList.add('hidden')
          document.body.appendChild(element)
        }
        return element
      },
      'battle-timer': () => {
        let element = document.getElementById('battle-timer')
        if (!element) {
          element = document.createElement('div')
          element.id = 'battle-timer'
          element.textContent = 'Battle Timer'
          document.body.appendChild(element)
        }
        return element
      },
      'challenge-name': () => {
        let element = document.getElementById('challenge-name')
        if (!element) {
          element = document.createElement('h2')
          element.id = 'challenge-name'
          element.textContent = 'Challenge'
          document.body.appendChild(element)
        }
        return element
      },
      'submit-solution-btn': () => {
        let element = document.getElementById('submit-solution-btn')
        if (!element) {
          element = document.createElement('button')
          element.id = 'submit-solution-btn'
          element.textContent = 'Submit Solution'
          document.body.appendChild(element)
        }
        return element
      }
    }

    const uiElements = {}
    const missingElements = []

    for (const [elementId, createElement] of Object.entries(requiredElements)) {
      try {
        uiElements[elementId] = createElement()
      } catch (error) {
        missingElements.push(elementId)
      }
    }

    if (missingElements.length > 0) {
      this.dispatch('battle-start-error', { 
        detail: { 
          missingElements,
          reason: 'Could not create UI elements' 
        } 
      })
      return
    }

    uiElements['challenge-name'].textContent = data.challenge_name || 'Unknown Challenge'

    uiElements['waiting-message'].classList.add('hidden')
    uiElements['battle-interface'].classList.remove('hidden')

    this.startBattleTimer(data.challenge_name)

    if (data.participants) {
      this.updateParticipantsUI(data.participants)
    }

    this.dispatch('battle-started', { 
      detail: { 
        challengeName: data.challenge_name,
        challengeId: data.challenge_id,
        participants: data.participants
      } 
    })
  }

  setupSubmitButton() {
    const addSubmitButtonListener = () => {
      try {
        const submitButton = this.element.querySelector('[data-battle-target="submit"]')
        
        if (submitButton) {
          submitButton.addEventListener('click', (event) => {
            event.preventDefault()
            
            let code = ''
            let methodTemplate = ''
            const textarea = document.getElementById('code-editor')
            
            if (window.battleEditor) {
              code = window.battleEditor.getValue()
            }
            
            if (!code && textarea) {
              code = textarea.value
            }
            
            if (textarea) {
              methodTemplate = textarea.getAttribute('data-method-template')
            }
            
            if (!code) {
              this.updateTestResults('Error: No code to submit')
              return
            }

            this.submitSolution(code, methodTemplate)
          })

          this.enableEditorAndSubmit()
        } else {
          setTimeout(addSubmitButtonListener, 500)
        }
      } catch (error) {
        console.error('Error setting up submit button:', error)
      }
    }

    addSubmitButtonListener()
  }

  handleBattleEnd(battleData) {
    this.disableEditorAndSubmit()

    const currentUserId = document.body.dataset.currentUserId
    const isWinner = battleData.winner_id === parseInt(currentUserId)
    const endMessage = isWinner 
      ? 'Congratulations! You won because your opponent disconnected.' 
      : 'You lost. Your opponent disconnected.'

    this.updateTestResults(`
      <div class="text-center ${isWinner ? 'text-green-500' : 'text-red-500'}">
        ${endMessage}
      </div>
    `)
  }

  handleDisconnection() {
    this.disableEditorAndSubmit()
    this.updateTestResults(`
      <div class="text-yellow-500 text-center">
        You've been disconnected from the room. 
        Please refresh the page or reconnect.
      </div>
    `)
  }

  handleRoomStatusUpdate(data) {
    console.group('Room Status Update')
    if (data.participants) {
      this.updateParticipantsUI(data.participants)
    }

    if (this.canStartBattle(data)) {
      this.initializeBattleStart(data)
    }
  }

  handleRoomStatus(data) {
    const statusElement = document.getElementById('room-status')
    if (statusElement) {
      statusElement.textContent = data.room_status || 'Unknown'
      statusElement.className = `status-${(data.room_status || 'unknown').toLowerCase()}`
    }

    const participantsCountElement = document.getElementById('participants-count')
    if (participantsCountElement) {
      participantsCountElement.textContent = 
        `${data.participants_count || 0}/2 Participants`
    }

    const waitingMessage = document.getElementById('waiting-message')
    const battleInterface = document.getElementById('battle-interface')

    if (data.room_status === 'ready' && waitingMessage && battleInterface) {
      waitingMessage.classList.add('hidden')
      battleInterface.classList.remove('hidden')
    } else if (data.room_status !== 'ready' && waitingMessage && battleInterface) {
      waitingMessage.classList.remove('hidden')
      battleInterface.classList.add('hidden')
    }
  }

  enableEditorAndSubmit() {
    if (this.hasEditorTarget) {
      this.editorTarget.disabled = false
    }
    
    if (this.hasSubmitTarget) {
      this.submitTarget.disabled = false
    }
  }

  disableEditorAndSubmit() {
    if (this.hasEditorTarget) {
      this.editorTarget.disabled = true
    }
    
    if (this.hasSubmitTarget) {
      this.submitTarget.disabled = true
    }
  }

  submitSolution(code, methodTemplate) {
    const pathParts = window.location.pathname.split('/')
    const roomCode = pathParts[pathParts.length - 1]
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content

    fetch(`/rooms/${roomCode}/submit_solution`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({ 
        room: {
          code: code,
          method_template: methodTemplate
        }
      })
    })
    .then(response => {
      if (!response.ok) {
        return response.text().then(errorText => {
          throw new Error(`HTTP error! status: ${response.status}, body: ${errorText}`)
        })
      }
      return response.json()
    })
    .then(data => {
      if (data.success) {
        this.updateTestResults(data.test_results_html)
      } else {
        this.updateTestResults('Submission failed: ' + (data.message || 'Unknown error'))
      }
    })
    .catch(error => {
      this.updateTestResults(`Error: ${error.message}`)
    })
  }

  disconnect() {
    if (this.subscription) {
      this.subscription.unsubscribe()
    }
  }

  initialize() {
    super.initialize()
    this.disableEditorAndSubmit()
  }

  updateTestResults(message) {
    if (this.hasTestResultsTarget) {
      this.testResultsTarget.innerHTML = `
        <div class="text-yellow-400 text-center">
          ${message}
        </div>
      `
    }
  }

  startBattleTimer(challengeName) {
    const timerElement = document.getElementById('battle-timer')
    if (!timerElement) return

    const battleDuration = 5 * 60
    let remainingTime = battleDuration

    const updateTimer = () => {
      const minutes = Math.floor(remainingTime / 60)
      const seconds = remainingTime % 60
      
      timerElement.textContent = `${challengeName}: ${minutes}:${seconds.toString().padStart(2, '0')}`
      
      if (remainingTime <= 0) {
        clearInterval(this.timerInterval)
        this.handleBattleTimeout()
        return
      }
      
      remainingTime--
    }

    if (this.timerInterval) {
      clearInterval(this.timerInterval)
    }

    updateTimer()
    this.timerInterval = setInterval(updateTimer, 1000)
  }

  handleBattleTimeout() {
    console.log('Battle time expired')
    
    const submitButton = document.getElementById('submit-solution-btn')
    if (submitButton) {
      submitButton.disabled = true
    }

    const timeoutMessage = document.getElementById('battle-timeout-message')
    if (timeoutMessage) {
      timeoutMessage.classList.remove('hidden')
    }

    this.dispatch('battle-timeout')
  }

  dispatch(eventName, detail = {}) {
    const event = new CustomEvent(eventName, { 
      detail,
      bubbles: true,
      cancelable: true
    })
    this.element.dispatchEvent(event)
  }
}
