$(document).ready(function(){
  $.validator.setDefaults({
    highlight: function(element, errorClass, validClass) {
      $(element).addClass(errorClass).removeClass(validClass);
      $(element).parent().addClass(errorClass);
      $(element).parent().parent().addClass(errorClass);
    },
    unhighlight: function(element, errorClass, validClass) {
      $(element).removeClass(errorClass).addClass(validClass);
      $(element).parent().removeClass(errorClass);

      if ($(element).parent().siblings('.error').length === 0) {
        $(element).parent().parent().removeClass(errorClass);
      }
    }
  });

  $.extend($.validator.messages, {
    required: "Campo obrigat&oacute;rio.",
    remote: "Por favor, corrija este campo.",
    email: 'Informe um email v&aacute;lido',
    url: "Informe uma URL v&aacute;lida.",
    date: "Por favor, forne&ccedil;a uma data v&aacute;lida.",
    dateISO: "Por favor, forne&ccedil;a uma data v&aacute;lida (ISO).",
    number: "Por favor, forne&ccedil;a um n&uacute;mero v&aacute;lido.",
    digits: "Por favor, forne&ccedil;a somente d&iacute;gitos.",
    creditcard: "Por favor, forne&ccedil;a um cart&atilde;o de cr&eacute;dito v&aacute;lido.",
    equalTo: "Informe o mesmo valor novamente.",
    accept: "Por favor, forne&ccedil;a um valor com uma extens&atilde;o v&aacute;lida.",
    maxlength: $.validator.format("Por favor, forne&ccedil;a n&atilde;o mais que {0} caracteres."),
    minlength: $.validator.format("Por favor, forne&ccedil;a ao menos {0} caracteres."),
    rangelength: $.validator.format("Por favor, forne&ccedil;a um valor entre {0} e {1} caracteres de comprimento."),
    range: $.validator.format("Por favor, forne&ccedil;a um valor entre {0} e {1}."),
    max: $.validator.format("Por favor, forne&ccedil;a um valor menor ou igual a {0}."),
    min: $.validator.format("Por favor, forne&ccedil;a um valor maior ou igual a {0}.")
  });
});

