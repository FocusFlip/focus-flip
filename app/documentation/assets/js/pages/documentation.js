/******/ (() => { // webpackBootstrap
/******/ 	"use strict";
var __webpack_exports__ = {};
/*!**********************************************!*\
  !*** ./src/assets/js/pages/documentation.js ***!
  \**********************************************/
/** Documentation */



$(document).ready(function () {
  // Sidebar Navigation Scrollspy
  let sections = {};
  $('section').each((_, e) => {
    sections[e.id] = e.offsetTop + 500;
  });

  $(window).scroll(function () {
    for (let key in sections) {
      if ($(window).scrollTop() >= sections[key]) {
        $('.js-nav__items').removeClass('active');
        $(`.js-nav__items[href="#${key}"]`).addClass('active');
      }
    }
  });


  // Toast Alert
  function tempAlert(msg, duration) {
    let el = document.createElement("div");
    el.classList.add("text-body-lg--medium");
    el.setAttribute("style", "position:fixed;top:24px;right:24px;background-color:#1E5DBC;color:#fff;z-index:9000;transition:all linear .2s;padding:16px;border-radius:6px;");
    el.innerHTML = msg;
    setTimeout(function () {
      el.parentNode.removeChild(el);
    }, duration);
    document.body.appendChild(el);
  }

  // Copy to Clipboard 
  async function copyContent(el) {
    let text = $(el).siblings('.text-code').text().trim();

    try {
      await navigator.clipboard.writeText(text);
      tempAlert("Code copied to clipboard", 2000);
    } catch (err) {
      tempAlert('Failed to copy: ' + err, 2000);
    }
  }

  // Copy to clipboard on copy button clicked 
  $('.btn-copy').on('click', function () {
    copyContent(this);
  });
});
/******/ })()
;
//# sourceMappingURL=documentation.js.map