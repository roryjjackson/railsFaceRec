import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

$(document).on('submit', 'form', function() {
  $('#loader').show();
});

$(document).ajaxComplete(function() {
  $('#loader').hide();
});


export { application }
