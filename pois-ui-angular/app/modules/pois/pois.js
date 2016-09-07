var criteriosDeBusqueda = [];

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
    	},
		criteriosDeBusqueda: function(){
			return criteriosDeBusqueda;
		}
    }
  })
  .state('main.editar_poi', {
    url: "/pois/editar/:id",
    templateUrl: "app/modules/pois/views/form.html",
    controller: "PoiCtrl",
    controllerAs: "formCtrl",
    resolve: {
		poi: function (PoisHome, $stateParams) {
			return PoisHome.get(parseInt($stateParams.id));
		}
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