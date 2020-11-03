import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["option", "input"]

  selectRadioOption() {
    const f = this.optionTarget.value
    this.inputTarget.innerHTML = f
  }
}
