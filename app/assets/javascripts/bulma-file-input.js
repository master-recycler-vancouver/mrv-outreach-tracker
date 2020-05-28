function fileUploadPreview() {
  const fileInput = document.querySelector(
    ".js-bulma-file-input-container .js-bulma-file-input"
  );

  if (fileInput) {
    fileInput.onchange = () => {
      if (fileInput.files.length > 0) {
        const fileName = document.querySelector(
          ".js-bulma-file-input-container .js-bulma-file-name"
        );
        fileName.textContent = fileInput.files[0].name;
      }
    };
  }
}

document.addEventListener("turbolinks:load", function () {
  fileUploadPreview();
});
