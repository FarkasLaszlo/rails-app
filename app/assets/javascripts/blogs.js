document.addEventListener('turbolinks:load', () => {
  if(/\/blogs\/[0-9a-zA-Z-_]+\/edit/.test(window.location.href)){

    const checkboxes = document.querySelectorAll('div > input[type="checkbox"]');
    checkboxes.forEach((checkbox) => {
      checkbox.getAttribute("data-checked") == "true" ? checkbox.setAttribute("checked", true) : null;
    })
  }
})

