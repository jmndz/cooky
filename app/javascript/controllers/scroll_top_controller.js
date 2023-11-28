import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll-top"
export default class extends Controller {
  connect() {
    window.addEventListener('scroll', (e) => {
      const backToTop = document.getElementById("back-to-top");

      // back to top button will be visible if the current scroll position of the window exceeds or equal to the maximum height of the screen
      if (window.scrollY >= screen.availHeight && backToTop) {
        backToTop.classList.remove("d-none");
      } else {
        backToTop.classList.add("d-none")
      }
    });
  }

  // scrolls window to the top of the page
  backToTop() {
    window.scrollTo({ top: 0, behavior: 'smooth'});
  }
}
