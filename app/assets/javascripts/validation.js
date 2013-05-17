$(document).ready(function(){
  $.extend($.validator.messages, {
    email: 'Informe um email válido',
    required: 'Campo obrigatório',
    url: 'Please enter a valid URL.',
    maxlength: $.validator.format('Please enter no more than {0} characters.'),
    minlength: $.validator.format('Please enter at least {0} characters.'),
  });

  //TODO: remove this from here... the loading order is breaking it
  $('#footer_form').validate();
});

