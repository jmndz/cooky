import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="recipes--home"
export default class extends Controller {
  static targets = ["ownRecipesTab", "othersRecipesTab", "newRecipeBtn"];

  selectRecipesTab() {
    // hide new recipe button on others' recipe tab
    if (this.othersRecipesTabTarget.classList.contains("active")){
      this.newRecipeBtnTarget.classList.add("d-sm-none");
    } else {
      this.newRecipeBtnTarget.classList.remove("d-sm-none");
    }
  }
}
