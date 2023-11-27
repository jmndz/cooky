import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="trix"
export default class TrixController extends Controller {
  connect() {
    document.addEventListener('trix-initialize', this.updateToolbar(), { once: true });
  }

  updateToolbar() {
    // remove toolbar buttons
    this.removeUndoButton();
    this.removeRedoButton();
    this.removeCodeButton();
    this.removeQuoteButton();

    // add toolbar buttons
    this.addUnderlineButton();

    // move toolbar buttons
    this.moveLinkButton();
    this.moveIndentButton();
    this.moveHeadingButton();

    // add divider to the button groups
    this.addDivider();
  }

  removeUndoButton() {
    document.querySelectorAll("[data-trix-action='undo']").forEach( el => { el.remove() } );
  }

  removeRedoButton() {
    document.querySelectorAll("[data-trix-action='redo']").forEach( el => { el.remove() } );
  }

  removeQuoteButton() {
    document.querySelectorAll("[data-trix-attribute='quote']").forEach( el => { el.remove() } );
  }

  removeCodeButton() {
    document.querySelectorAll("[data-trix-attribute='code']").forEach( el => { el.remove() } );
  }

  addUnderlineButton() {
    // initialize underline attribute
    Trix.config.textAttributes.underline = {
      tagName: "u",
      style: { textDecoration: "underline" },
      inheritable: true,
      parser: function (element) {
        let style = window.getComputedStyle(element);
        return style.textDecoration === "underline";
      },
    };

    // add button to toolbar - inside the text tools group
    document.querySelectorAll(".trix-button-group--text-tools").forEach(el => {
      let italicButton = el.querySelector("[data-trix-attribute='italic']");

      // create underline button
      let underlineEl = this.createUnderlineButton();
      
      italicButton.insertAdjacentElement("afterend", underlineEl);
    });
  }

  createUnderlineButton() {
    let underlineEl = document.createElement("button");

    // set button attributes
    underlineEl.setAttribute("type", "button");
    underlineEl.setAttribute("data-trix-attribute", "underline");
    underlineEl.setAttribute("data-trix-key", "u");
    underlineEl.setAttribute("tabindex", -1);
    underlineEl.setAttribute("title", "underline");
    underlineEl.classList.add("trix-button", "trix-button--icon", "trix-button--icon-underline");

    return underlineEl;
  }

  moveLinkButton() {
    let linkButtons = document.querySelectorAll("[data-trix-action='link']");

    linkButtons.forEach(el => {
      let attachFilesButton = el.closest("trix-toolbar").querySelector("[data-trix-action='attachFiles']");

      // insert link button next to attach files button
      attachFilesButton.insertAdjacentElement("beforebegin", el);
    });
  }

  moveIndentButton() {
    let decreaseIndentButtons = document.querySelectorAll(".trix-button--icon-decrease-nesting-level");

    decreaseIndentButtons.forEach(el => {
      let increaseIndentButton = el.parentElement.querySelector(".trix-button--icon-increase-nesting-level");

      //insert decrease indent button to the right side of the increase indent button
      increaseIndentButton.insertAdjacentElement("afterend", el)
    });
  }

  moveHeadingButton() {
    let headingButtons = document.querySelectorAll(".trix-button--icon-heading-1");

    headingButtons.forEach(el => {
      let textTools = el.closest("trix-toolbar").querySelector(".trix-button-group--text-tools");
      
      // insert headingButton before text tools button group
      textTools.insertAdjacentElement("beforebegin", el);
    });
  }

  addDivider() {
    let buttonGroupNames = [
      ".trix-button--icon-heading-1",
      ".trix-button-group--text-tools", 
      ".trix-button-group--block-tools",
      ".trix-button--icon-number-list"
    ];

    buttonGroupNames.forEach(buttonGroup => {
      let buttonGroupElements = document.querySelectorAll(buttonGroup);

      // add divider for all trix toolbar
      buttonGroupElements.forEach(el => {
        el.insertAdjacentHTML("afterend", this.dividerTemplate);
      });
    });
  }

  get dividerTemplate() {
    return `
      <div class="vr text-muted mx-2"></div>
    `;
  }
}
