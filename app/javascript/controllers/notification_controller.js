import ApplicationController from "controllers/application_controller"

export default class extends ApplicationController {
  static targets = ["content"]

  connect() {
    console.log("Notification controller connected")
    StimulusReflex.register(this)
    this.open = false
  }

  toggle() {
    if (this.open) {
      this._hide()
    } else {
      this.show()
    }
  }

  show() {
    this.open = true
    this.contentTarget.classList.add("open")
    this.element.setAttribute("aria-expanded", "true")
  }

  _hide() {
    this.open = false
    this.contentTarget.classList.remove("open")
    this.element.setAttribute("aria-expanded", "false")
  }

  hide() {
    if (this.element.contains(event.target) === false && this.open) {
      this._hide()
    }
  }

  read() {
    this.stimulate("Notification#read", this.element)
  }

  beforeRead(element) {
    element.classList.add("opacity-0")
    setTimeout(() => {
      element.remove()
    }, 150);
  }
}
