$(document).ready(function(){
  $.extend($.inputmask.defaults.aliases, {
      "cellphone": {
        mask: "(99) 9999[9]-9999"
      },
      "phone": {
        mask: "(99) 9999-9999"
      }
  });

  $(":input").inputmask();
});
