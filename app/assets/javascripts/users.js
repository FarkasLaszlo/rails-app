document.addEventListener('turbolinks:load', () => {
  if(window.location.href.includes("registration")){
    let input = document.querySelector('input.file-upload');
    let preview = document.querySelector('.preview');
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
      let list = document.createElement('div');
      preview.appendChild(list);
      curFiles.forEach((currentFile) => {
        let image = document.createElement('img');
        image.src = window.URL.createObjectURL(currentFile);
        list.appendChild(image);
      })
    }
  }
})
