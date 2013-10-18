(function(){
  // Initializes locals container for the global scope.
  // All _locals.js file will inherit all locals here by default.
  //
  // Define a local by adding property to 'locals'.
  //
  // Example:
  // locals.localMethod = function(){};
  var locals = Paloma.locals['/'] = {};


  locals.selectizeCityAndState = function() {
    var xhr;
    var selectState, $selectState;
    var selectCity, $selectCity;

    $selectState = $('#user_address_state').selectize({
      onChange: function(value) {
        if (!value.length) return;

        selectCity.disable();
        selectCity.clearOptions();
        selectCity.load(function(callback) {
          xhr && xhr.abort();

          xhr = $.ajax({
            url: '/get_cities_by_uf/'+ value,
            success: function(results) {
              selectCity.enable();
              callback(results);
            },
            error: function() {
              callback();
            }
          })
        });
      }
    });

    $selectCity = $('#user_address_city').selectize({
      valueField: 'name',
      labelField: 'name',
      searchField: ['name'],
      dataAttr: 'data-name',
    });

    selectCity  = $selectCity[0].selectize;
    selectState = $selectState[0].selectize;

    if (!selectState.getValue()) selectCity.disable();
  };
})();
