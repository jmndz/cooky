import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="password"
export default class extends Controller {
  showPassword(event) {
    const password = event.currentTarget.closest(".password").querySelector("input");

    if (password.type == "password"){
      password.type = "text";
    } else {
      password.type = "password";
    }
  }
}
