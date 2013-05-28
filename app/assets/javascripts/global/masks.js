$(document).ready(function(){
  $.extend($.inputmask.defaults.aliases, {
      "phone": {
        mask: "(99) 9999[9]-9999"
      }
    }
  });

  $(":input").inputmask();
});
