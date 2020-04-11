import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "menu", "button" ]

  toggle(event) {
    this.toggleButton()
    this.toggleMenu()
  }

  toggleButton() {
    this.buttonTarget.classList.toggle('is-active')
  }

  toggleMenu() {
    this.menuTarget.classList.toggle('is-active')
  }
}
