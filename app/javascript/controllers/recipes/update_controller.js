import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from "@rails/request.js"

// Connects to data-controller="recipes--update"
export default class extends Controller {
  initialize() {
    this.dialog = document.getElementById("turbo-confirm");
  }

  async saveChanges(event) {
    event.preventDefault();

    const form = event.currentTarget.closest("form"),
          formData = new FormData(form),
          okBtn = this.dialog.querySelector(".ok-btn");

    this.action = form.action
    
    // save changes made to recipe
    const request = new FetchRequest("patch", this.action, { 
      body: formData,
      responseKind: "json" 
    });

    const response = await request.perform();
    const data = await response.json;

    if (data.success) {
      this.changeDialogContent(this.dialog, "save-success");

      this.dialog.showModal();

      return new Promise(() => {
        okBtn.addEventListener("click", () => this.redirectUserToRecipePage(), { once: true });
      });
    } else {
      this.dialog.close();
    }
  }

  showCancelModal(event) {
    event.preventDefault();

    const noBtn = document.querySelector(".no-btn"),
          yesBtn = document.querySelector(".yes-btn");

    this.action = event.currentTarget.href;

    this.changeDialogContent(this.dialog, "cancel");

    this.dialog.showModal();

    return new Promise(() => {
      noBtn.addEventListener("click", () => this.dialog.close());
      yesBtn.addEventListener("click", () => this.redirectUserToRecipePage());
    });
  }

  redirectUserToRecipePage() {
    Turbo.visit(this.action, { action: "replace" });
  }

  changeDialogContent(dialog, action) {
    let titleSpans = dialog.querySelectorAll(".title > span"),
        contentSpans = dialog.querySelectorAll(".content > span"),
        yesOrNoBtn = dialog.querySelector(".yes-or-no-btn"),
        okBtn = dialog.querySelector(".ok-btn");

    // hide title for other actions
    titleSpans.forEach(span => {
      if (span.classList.contains(action)) {
        span.classList.remove("d-none");
      } else {
        span.classList.add("d-none");
      }
    });

    // hide content for other actions
    contentSpans.forEach(span => {
      if (span.classList.contains(action)) {
        if (action == "save-success") {
          span.querySelector(".recipe-name").textContent = this.recipeName;
        }

        span.classList.remove("d-none");
      } else {
        span.classList.add("d-none");
      }
    });

    // show button depending on the action
    if (action == "cancel") {
      yesOrNoBtn.classList.remove("d-none");
      okBtn.classList.add("d-none");
    } else {
      yesOrNoBtn.classList.add("d-none");
      okBtn.classList.remove("d-none");  
    }
  }
}
