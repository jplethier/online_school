(function(){
  // You access variables from before/around filters from _x object.
  // You can also share variables to after/around filters through _x object.
  var _x = Paloma.variableContainer;

  // We are using _L as an alias for the locals container.
  // Use either of the two to access locals from other scopes.
  //
  // Example:
  // _L.otherController.localVariable = 100;
  var _L = Paloma.locals;

  // Access locals for the current scope through the _l object.
  //
  // Example:
  // _l.localMethod();
  var _l = _L['employees'];


  Paloma.callbacks['employees']['edit'] = function(params){
    _l.selectizeCityAndState();

    $('form').on('click', '.fa-lock', function() {
      unlockPassword();
    });

    $('form').on('click', '.fa-unlock', function() {
      lockPassword();
    });

    function lockPassword() {
      $('.fa-unlock').removeClass('fa-unlock').addClass('fa-lock');

      $('#user_password').val('').prop('disabled', true);
      $('#user_password_confirmation').val('').prop('disabled', true);
    }

    function unlockPassword() {
      $('.fa-lock').removeClass('fa-lock').addClass('fa-unlock');

      $('#user_password').prop('disabled', false);
      $('#user_password_confirmation').prop('disabled', false);
    }
  };
})();
