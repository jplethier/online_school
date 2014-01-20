$(document).ready(function(){
  $('form[data-validate]').validate();

  $('*[data-selectize]').selectize();

  $('tr[data-url]').each(function() {
    $(this).on('click', function() {
      window.location.href = $(this).data('url');
    });
  });

  $('*[data-dual-selectize]').each(function() {
    var $selectized_select, selectized_select;
    var $container = $(this);
    var $select    = $container.children('.select');
    var $list      = $container.children('.list');

    $selectized_select = $container.find('.select select').selectize({
      plugins: ['restore_on_backspace'],
      onInitialize: function() {
        $select.find('.selectize-input input').attr('placeholder', $container.data('search-placeholder'));

        if ($select.find('.selectize-input div').length == 0) {
          $list.find('.blank').show();
        } else {
          $list.find('.blank').hide();
        }
      },
      onItemAdd: function(value, $item) {
        var $input = $list.find('li input[value="' + value + '"]');

        $list.find('.blank').hide();

        if ($input.length == 0) {
          var $clone = $list.find('.template').clone().removeClass('template');
          $clone.find(':input').prop('disabled', false);

          $list.find('ul').append($clone.html().replace(/{{text}}/g, $item.text()).replace(/{{value}}/g, value).replace(/{{random}}/g, new Date().getTime()));
        } else {
          $input.prop('disabled', false);
          $input.siblings('.destroy').prop('disabled', false);
          $input.siblings('.destroy').val(false);
          $input.parent().show();
        }

        if ($container.find('.selectize-dropdown-content div').length == 0){
          $select.find('.selectize-input input').attr('placeholder', $container.data('empty-search-list'));
          selectized_select.disable();
        } else {
          $select.find('.selectize-input input').attr('placeholder', $container.data('search-placeholder'));
        }
      },
      onItemRemove: function(value, $item) {
        $select.find('.selectize-input input').attr('placeholder', $container.data('search-placeholder'));
        selectized_select.enable();

        if ($select.find('.selectize-input div').length == 0) {
          $list.find('.blank').show();
        }
      }
    })

    selectized_select  = $selectized_select[0].selectize;

    $container.on('click', '.remove-fields', function() {
      selectized_select.removeItem($(this).data('objectId'));
      $(this).parent().remove();
    });

    $container.on('click', '.destroy-fields', function() {
      selectized_select.removeItem($(this).data('objectId'));
      $(this).parent().hide();
      $(this).parent().find('input.destroy').val('1')
    });
  });
});
