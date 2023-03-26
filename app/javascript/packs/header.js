document.addEventListener('DOMContentLoaded', () => {
  document.getElementById("nav_for_Hamburger").style.display = "none";

  window.clickBtn1 = function () {
    const nav = document.getElementById("nav_for_Hamburger");
    const btn = document.getElementById("toggle-btn")
    if (nav.style.display == "block") {
      nav.style.display = "none";
      btn.className = "fas fa-bars"
    } else {
      nav.style.display = "block";
      btn.className = "fa-solid fa-xmark"
    }
  }
});
