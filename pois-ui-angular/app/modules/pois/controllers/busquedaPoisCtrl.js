function BusquedaPoisCtrl(pois) {
  var self = this;
  self.pois = pois;
}

angular.module("pois-app")
.controller("BusquedaPoisCtrl", BusquedaPoisCtrl);

BusquedaPoisCtrl.$inject = [ "pois"];