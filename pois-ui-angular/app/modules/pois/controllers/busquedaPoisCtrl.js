function BusquedaPoisCtrl(pois, PoisHome) {
	var self = this;
	self.pois = pois;
	self.nuevoCriterio = ""; // String
	self.criteriosDeBusqueda = []; // Lista de String
	self.criterioSeleccionado = "";
  
	// FUNCIÓN 'BUSCAR':
	self.buscar = function() {
		
		self.poisBusqueda = [];
		
		_(self.pois).forEach(function(poi) {
			var self2 = this;
			self2.poi = poi;
			_(self.criteriosDeBusqueda).forEach(function(criterio) {
				if (_.includes(self2.poi.nombre, criterio) || _.includes(self2.poi.palabrasClave, criterio)){
					self.poisBusqueda.push(self2.poi);
				}
			});
		});
		
		
		
	};
	
	self.agregarCriterio = function() {
		if(self.nuevoCriterio != "" &&  !(_.includes(self.criteriosDeBusqueda, self.nuevoCriterio))){			
			self.criteriosDeBusqueda.push(self.nuevoCriterio);			
		}
		self.nuevoCriterio = "";
	};
	
	self.quitarCriterio = function() {
		function remove(arr, item) {
			 for(var i = arr.length; i--;) {
				 if(arr[i] === item) {
					 arr.splice(i, 1);
				 }
			 }
		}
		remove(self.criteriosDeBusqueda, self.criterioSeleccionado);
		self.criterioSeleccionado = "";
	};
}

angular.module("pois-app")
.controller("BusquedaPoisCtrl", BusquedaPoisCtrl);

BusquedaPoisCtrl.$inject = [ "pois", "PoisHome" ];