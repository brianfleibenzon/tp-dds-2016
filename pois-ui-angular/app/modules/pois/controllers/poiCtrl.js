// ** FUNCIÓN CONSTRUCTORA: POI_CONTROLLER **
function PoiCtrl(PoisHome, poi, $state, nombreController) {

	var self = this;
	self.poi = poi;
	self.tiposDePoi = [ /*** COMPLETAR ***/ ];
	  
	self.abrirTipoPoi = function () {
		$state.go("main." + nombreController + "_pois." + self.poi.tipo.nombre.toLowerCase());
	};
};

angular.module("pois-app")
.controller("PoiCtrl", PoiCtrl);

PoiCtrl.$inject = [ "PoisHome", "poi", "$state", "nombreController" ];