import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["option", "input", "submit", "text", "guillo"]

  selectRadioOption() {
    this.optionTargets.forEach((something, i) => {
      something.classList.toggle("active", event.target == something)
    })
    // this.optionTargets.forEach((el, i) => {
    //   el.classList.toggle("active", event.target == el )
    // })
    this.inputTarget.value = event.target.innerText
  }
}

