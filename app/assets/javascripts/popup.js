var Popup = {
  state: {},

  actions : { 'default' : { 'data' :  null,
                            'url'  : '/'}
            },

  open_url : function(url) {
    $('#blocker').height($(document).height());
    $('#blocker').show();
    $('#popup .content').html('');
    $('#popup').show();

    $.ajax({
      type: 'GET',
      data: {},
      url: url,
      success: function(html) {
        $('#popup .main_popup').show().html(html);
      }
    });
  },

  close : function() {
    $('#blocker').hide();
    $('#popup').hide();
    $('#popup iframe').remove()

    return false;
  }
}