document.addEventListener("turbolinks:load", function() {
  initDatepickers();
});

function initDatepickers() {
  var calendarOptions = {
    isRange: true,
    minuteSteps: 15, //in case we ever use this for duration, 15 minute minimum,
    dateFormat: "DD/MM/YYYY",
    labelFrom: "Start Date",
    labelTo: "End Date"
  };
  // Initialize all input of type datetime
  var calendars = bulmaCalendar.attach('[type="datetime"]', calendarOptions);
}
