function BusquedaPoisCtrl(pois, PoisHome, criteriosDeBusqueda) {

    var self = this;
    self.pois = pois;
    self.nuevoCriterio = ""; // String
    self.criteriosDeBusqueda = criteriosDeBusqueda; // Lista de String
    self.criterioSeleccionado = criteriosDeBusqueda[0];
    self.errorMessage = "";
    self.nothingFoundMessage = "";

    // FUNCIÓN 'BUSCAR':
    self.buscar = function() {

        self.errorMessage = "";
        self.nothingFoundMessage = "";
		
		self.poisBusqueda = [];
		
        if (self.criteriosDeBusqueda.length === 0) {

            self.errorMessage = "No ha ingresado ningún criterio de búsqueda.";
        } else {           

            _(self.pois).forEach(function(poi) {
                var self2 = this;
                self2.poi = poi;
				self2.poiIncluido = false;
                _(self.criteriosDeBusqueda).forEach(function(criterio) {
                    if (!poiIncluido && (_.includes(self2.poi.nombre, criterio) || _.includes(self2.poi.palabrasClave, criterio))) {
						self.poisBusqueda.push(self2.poi);
						self2.poiIncluido = true;
                    }
                });
            });
            if (self.poisBusqueda.length === 0) self.nothingFoundMessage = "No se han encontrado resultados para su búsqueda.";
        }
    };

    self.agregarCriterio = function() {
        if (self.nuevoCriterio !== "" && !(_.includes(self.criteriosDeBusqueda, self.nuevoCriterio))) {
            self.criteriosDeBusqueda.push(self.nuevoCriterio);
            self.criterioSeleccionado = self.criteriosDeBusqueda[self.criteriosDeBusqueda.length - 1];
        }
        self.nuevoCriterio = "";
    };

    self.quitarCriterio = function() {
        function remove(arr, item) {
            for (var i = arr.length; i--;) {
                if (arr[i] === item) {
                    arr.splice(i, 1);
                }
            }
        }
        remove(self.criteriosDeBusqueda, self.criterioSeleccionado);
        self.criterioSeleccionado = self.criteriosDeBusqueda[0];
    };
	
	if (self.criteriosDeBusqueda.length !== 0) {
		self.buscar();
	}
}

angular.module("pois-app")
    .controller("BusquedaPoisCtrl", BusquedaPoisCtrl);

BusquedaPoisCtrl.$inject = ["pois", "PoisHome", "criteriosDeBusqueda"];