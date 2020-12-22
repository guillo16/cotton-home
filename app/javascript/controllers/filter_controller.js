import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "color"]

  hideFilters() {
    this.colorTarget.classList.toggle("show");
  }

}
