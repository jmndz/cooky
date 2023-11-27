// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import "trix"
import "@rails/actiontext"


// modify confirmation message
Turbo.setConfirmMethod((message, element, button) => {
  let dialog = document.getElementById("turbo-confirm");
  dialog.showModal();

  return new Promise((resolve, reject) => {
    dialog.addEventListener("close", () => {
      resolve(dialog.returnValue == "confirm")
    }, { once: true });
  });
});