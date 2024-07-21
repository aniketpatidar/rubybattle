import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]

  connect() {
    console.log("Notification controller connected")
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
}
