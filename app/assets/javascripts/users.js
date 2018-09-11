document.addEventListener('turbolinks:load', () => {
  const url = window.location.href;

  if(/\/users\/[0-9a-zA-Z-_]+\/edit$/.test(url)){

    const radioboxes = document.querySelectorAll('div > input[type="radio"]');

    radioboxes.forEach((radiobox) => {
      radiobox.getAttribute("data-checked") == "true" ? radiobox.setAttribute("checked", true) : null;
    })
  }

  if(url.includes("registration") || /\/users\/[0-9a-zA-Z-_]+\/edit$/.test(url)){

    const input = document.querySelector('input.file-upload');
    const preview = document.querySelector('.preview');
    const emailField = document.querySelector('input.email');
    const original_text_container = document.querySelector(".preview > p")

    input.style.opacity = 0;
    input.addEventListener('change', handleImageUpload(event, original_text_container && original_text_container.textContent || ""));
    emailField.addEventListener('input', updateEmail);
  }

  if(url.includes("registration")) {
    const passwordField = document.querySelector('input.password');
    const passwordRevealButton = document.querySelector('button.password-show');

    passwordField.addEventListener('input', updatePasswordConfirmation);
    passwordRevealButton.addEventListener('click', togglePassword);
  }
})

function togglePassword() {
  const password_field = document.querySelector('.password');
  const password_confirmation_field = document.querySelector('.password-confirmation');
  if(password_field.type === "password") {
    password_field.type = "text";
    password_confirmation_field.type = "text";
  } else {
    password_field.type = "password";
    password_confirmation_field.type = "password";
  }
}


function handleImageUpload(event, original_text) {
  return function updateImageDisplay() {
    const input = document.querySelector('input.file-upload');
    const preview = document.querySelector('.preview');
    const curFiles = input.files;

    preview.innerHTML = "";
    if(curFiles.length === 0) {
      if(original_text === "") {
        const para = document.createElement('img');
        para.src = "/placeholder-user.png";
        preview.appendChild(para);
      } else {
        const para = document.createElement('p');
        para.textContent = original_text;
        preview.appendChild(para);
      }
    } else {
      const image = document.createElement('img');
      image.src = window.URL.createObjectURL(curFiles[0]);
      preview.appendChild(image);
    }
  }
}

function updateEmail(event) {
  const emailField = document.querySelector('input.email');
  /^([a-z0-9-]+(\.[a-z0-9-]+)*)@(([a-z\-0-9]+\.)+[a-z]{2,})$/.test(emailField.value) ? emailField.setCustomValidity("") : emailField.setCustomValidity("Email is not valid");
}

function updatePasswordConfirmation(event) {
  const passwordField = document.querySelector('input.password');
  const passwordConfirmation = document.querySelector('input.password-confirmation');
  passwordConfirmation.setAttribute("pattern", passwordField.value);
}
