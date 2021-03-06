// = require decidim/foundation
// = require modernizr
// = require svg4everybody.min
// = require morphdom
// = require moment.min
// = require foundation-datepicker
// = require form_datepicker
// = require decidim/history
// = require decidim/append_elements
// = require decidim/user_registrations

/* globals svg4everybody */

window.Decidim = window.Decidim || {};

$(() => {
  $(document).foundation();
  svg4everybody();
  if (window.Decidim.formDatePicker) {
    window.Decidim.formDatePicker();
  }
});
