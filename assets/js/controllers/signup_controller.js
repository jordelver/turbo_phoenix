import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "fieldset", "submit" ]

  submit(event) {
    this.grayOutForm()
    this.showLoadingSpinner()
  }

  showLoadingSpinner() {
    this.submitTarget.classList.add('is-loading')
  }

  grayOutForm() {
    this.fieldsetTarget.setAttribute('readonly', 'readonly')
  }
}
