angular.module('pois-app')
.config(function($stateProvider) {
  return $stateProvider
  .state('main.busqueda_pois', {
    url: "/pois",
    templateUrl: "app/modules/pois/views/busqueda.html",
    controller: "BusquedaPoisCtrl",
    controllerAs: "busquedaCtrl",
    resolve: {
    	pois: function (PoisHome) {
    		return PoisHome.getAll();
    	}
    }
  })
  .state('main.editar_poi', {
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
  .state('main.editar_poi.parada', {
    views : { "tipo-poi": { templateUrl: "app/modules/pois/views/paradaForm.html" } }
  })
  .state('main.editar_poi.banco', {
    views : { "tipo-poi": { templateUrl: "app/modules/pois/views/bancoForm.html" } }
  })
  .state('main.editar_poi.comercio', {
    views : { "tipo-poi": { templateUrl: "app/modules/pois/views/comercioForm.html" } }
  })
  .state('main.editar_poi.cgp', {
    views : { "tipo-poi": { templateUrl: "app/modules/pois/views/cgpForm.html" } }
  })
});