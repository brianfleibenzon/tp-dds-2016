// ** FUNCIÓN CONSTRUCTORA: BUSQUEDA_POIS_CONTROLLER **
function BusquedaPoisCtrl(pois) {
    var self = this;
    this.nuevoCriterio = ''; // String
    this.criteriosDeBusqueda = null; // Lista de String
    this.resultadoDeBusqueda = null; // Lista de resultados POI
    var repoPois = [{
        'nombre': 'Banco de la Plaza',
        'direccion': 'Paraguay 1135',
        'sucursal': 'Avellaneda',
        'rangoAtencion': 'Lun a Vier 10.00hs a 15.00hs',
        'palabrasClave': ['cobro cheques', 'depósitos', 'extracciones', 'transferencias', 'créditos']
    }, {
        'nombre': 'CGP Comuna 1',
        'direccion': 'Medrano 950',
        'barrios': 'Puerto Madero-Retiro-San Nicolás',
        'servicios': ['cultura', 'deportes', 'turismo'],
        'rangoAtencion': 'Lun a Sáb 9.00hs a 13.00hs y 16.30hs a 20.30hs',
        'palabrasClave': ['centro de atención', 'comuna', 'servicios sociales']
    }, {
        'nombre': 'Farmacia Farmacity',
        'direccion': 'Corrientes 5081',
        'rubro': 'farmacia',
        'rangoAtencion': 'Lun a Sáb 8.00hs a 21.00hs',
        'palabrasClave': ['comercio', 'medicamentos', 'salud', 'farmacia']
    }, {
        'nombre': 'Parada Línea 7',
        'direccion': 'Mozart 2300',
        'palabrasClave': ['utn', 'colectivo', 'lugano', 'parada']
    }]; // Colección de POI

    // FUNCIÓN 'BUSCAR':
    this.buscar = function() {
        var local_self = this;
        var resultadosSet = new Set();

        this.buscarPoisEnRepo = function(criterio) {
            var search = _.filter(repoPois, function(poi) {
                return _.includes(poi.nombre, criterio) || _.includes(poi.palabrasClave, criterio);
            });

            local_self.resultadoSet.concat(search);
        };

        if (self.criteriosDeBusqueda !== null) {
            self.criteriosDeBusqueda.forEach(this.buscarPoisEnRepo);
        }
        self.resultadoDeBusqueda.concat(resultadosSet);
    };

    this.agregarCriterio = function() {
        if (self.nuevoCriterio !== '') {
            self.criteriosBusqueda.push(self.nuevoCriterio);
        }
    };

    this.quitarCriterio = function() {
        if (self.nuevoCriterio !== '') {
            self.criteriosBusqueda.pop(self.nuevoCriterio);
        }
    };
}

var pois_app = angular.module('pois-app');
pois_app.controller('BusquedaPoisCtrl', BusquedaPoisCtrl);

BusquedaPoisCtrl.$inject = ['pois'];