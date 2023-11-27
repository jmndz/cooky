import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image"
export default class extends Controller {
  static targets = ["fileName"];

  upload(event) {
    const uploadedFileName = event.currentTarget.files[0]?.name;

    if (uploadedFileName) {
      // display file name
      this.fileNameTarget.textContent = uploadedFileName;
    }
  }
}
