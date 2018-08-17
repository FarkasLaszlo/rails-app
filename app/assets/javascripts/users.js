document.addEventListener('turbolinks:load', () => {
  const url = window.location.href;
  if(url.includes("registration") || /\/users\/[0-9a-zA-Z-_]+\/edit/.test(url)){
    var input = document.querySelector('input.file-upload');
    var preview = document.querySelector('.preview');
    input.style.opacity = 0;
    let label = document.querySelector('div.form-group > label.file-upload');
    input.addEventListener('change', updateImageDisplay);
    label.textContent = "Click here to upload a profile picture";
  }
  function updateImageDisplay() {
    while(preview.firstChild) {
      preview.removeChild(preview.firstChild);
    }
    let curFiles = input.files;
    if(curFiles.length === 0) {
      let para = document.createElement('p');
      para.textContent = 'No files currently selected for upload';
      preview.appendChild(para);
    } else {
      const list = document.createElement('div');
      preview.appendChild(list);
      const image = document.createElement('img');
      image.src = window.URL.createObjectURL(curFiles[0]);
      list.appendChild(image);
    }
  }
})
