import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from "@rails/request.js"

// Connects to data-controller="recipes--destroy"
export default class extends Controller {
  initialize() {
    this.dialog = document.getElementById("turbo-confirm");
  }

  showDestroyModal(event) {
    event.preventDefault();

    const noBtn = document.querySelector(".no-btn"),
          yesBtn = document.querySelector(".yes-btn");
    
    this.recipeName = event.currentTarget.dataset.recipename;
    this.action = event.currentTarget.href;

    this.changeDialogContent(this.dialog, "delete");

    this.dialog.showModal();

    return new Promise(() => {
      noBtn.addEventListener("click", () => this.cancelDeletionRequest());
      yesBtn.addEventListener("click", () => this.confirmDeletion());
    });
  }

  async confirmDeletion() {
    const okBtn = document.querySelector(".ok-btn");

    // proceed with recipe deletion
    const request = new FetchRequest("delete", this.action, { responseKind: "json" });

    const response = await request.perform();
    const data = await response.json;

    if (data.success) {
      this.changeDialogContent(this.dialog, "delete-confirmation");

      this.dialog.showModal();

      return new Promise(() => {
        okBtn.addEventListener("click", () => this.redirectUserToHome());
      });
    } else {
      this.cancelDeletionRequest();
    }
  }

  cancelDeletionRequest() {
    this.dialog.close();
  }

  redirectUserToHome() {
    Turbo.visit(window.location.origin, { action: "replace" });
  }

  changeDialogContent(dialog, action) {
    let titleSpans = dialog.querySelectorAll(".title > span"),
        contentSpans = dialog.querySelectorAll(".content > span"),
        yesOrNoBtn = dialog.querySelector(".yes-or-no-btn"),
        okBtn = dialog.querySelector(".ok-btn"),
        noBtn = yesOrNoBtn.querySelector(".no-btn"),
        yesBtn = yesOrNoBtn.querySelector(".yes-btn");

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
        span.querySelector(".recipe-name").textContent = this.recipeName;
        span.classList.remove("d-none");
      } else {
        span.classList.add("d-none");
      }
    });

    // show button depending on the action
    if (action == "delete") {
      yesOrNoBtn.classList.remove("d-none");
      okBtn.classList.add("d-none");
    } else {
      yesOrNoBtn.classList.add("d-none");
      okBtn.classList.remove("d-none");  
    }
  }
}
