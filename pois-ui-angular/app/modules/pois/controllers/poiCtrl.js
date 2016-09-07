// ** FUNCIÓN CONSTRUCTORA: POI_CONTROLLER **
function PoiCtrl(PoisHome, poi, $state) {

	var self = this;
	self.poi = poi;
	
	document.body.scrollTop;
};

angular.module("pois-app")
.controller("PoiCtrl", PoiCtrl);

PoiCtrl.$inject = [ "PoisHome", "poi", "$state"];