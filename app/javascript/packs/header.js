document.addEventListener('DOMContentLoaded', () => {
  document.getElementById("nav_for_Hamburger").style.display = "none";

  window.clickBtn1 = function () {
    const nav = document.getElementById("nav_for_Hamburger");
    const btn = document.getElementById("toggle-btn");
    const logo = document.getElementById("logo");
    if (nav.style.display == "block") {
      nav.style.display = "none";
      logo.style.display = "block";
      btn.className = "fas fa-bars"
    } else {
      nav.style.display = "block";
      logo.style.display = "none";
      btn.className = "fa-solid fa-xmark col-6"
    }
  }
});
