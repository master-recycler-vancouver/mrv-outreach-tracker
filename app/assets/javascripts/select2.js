function initializeSelect2(selector) {
  const $formSelectElem = $(selector);
  if (!$formSelectElem.length) {
    return;
  }

  $formSelectElem.each(function() {
    let $input = $(this);

    $input.select2({
      dropdownAutoWidth: false,
      placeholder: "select2PlaceholderText" in $input.data() ? $input.data().select2PlaceholderText : "Select",
      width: "100%"
    });
  });
}

$(document).on("turbolinks:load", function() {
  initializeSelect2(".js-form-select2");
});
