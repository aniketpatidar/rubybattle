import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="copy-to-clipboard"
export default class extends Controller {

  async copy(event) {
    event.preventDefault()
    this.showSuccess()

    try {
      await navigator.clipboard.writeText(this.element.dataset.url)
    } catch {}
  }

  showSuccess() {
    this.messageTarget = document.querySelector(`#message`);
    this.messageTarget.classList.remove('hidden')

    setTimeout(() => {
      this.messageTarget.classList.add('hidden')
    }, 1000)
  }
}
