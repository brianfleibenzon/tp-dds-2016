angular.module('pois-app')
.config(function($stateProvider) {
  return $stateProvider
  .state('main.busqueda_pois', {
    url: "/pois",
    templateUrl: "app/modules/pois/views/busqueda.html",
    controller: "BusquedaPoisCtrl",
    controllerAs: "busquedaCtrl",
    resolve: {
    	poi: function (PoisHome) {
    		return PoisHome.getAll()
    	}
    }
  })/* SEGUIR DESDE ACA*/
  .state('main.editar_pois', {
    url: "/pois/editar/:id",
    templateUrl: "app/modules/pois/views/form.html",
    controller: "PoisCtrl",
    controllerAs: "formCtrl",
    resolve: {
      poi: function (PoisHome, $stateParams) {
        return PoisHome.get(parseInt($stateParams.id));
      },
      nombreController: function () { return "editar"; }
    }
  })
  .state('main.editar_propiedades.hotel', {
    views : { "tipo-poi": { templateUrl: "app/modules/propiedades/views/hotelForm.html" } }
  })
  .state('main.editar_propiedades.particular', {
    views : { "tipo-poi": { templateUrl: "app/modules/propiedades/views/particularForm.html" } }
  })
});