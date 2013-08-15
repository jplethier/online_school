$(document).ready(function(){
  $('form[data-validate]').validate();

  $('*[data-selectize]').selectize();

  $('tr[data-url]').each(function() {
    $(this).on('click', function() {
      window.location.href = $(this).data('url');
    });
  });
});
