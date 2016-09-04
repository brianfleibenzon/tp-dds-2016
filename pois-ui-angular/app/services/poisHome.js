var poiIdActual = 1;

// ** FUNCIÓN CONSTRUCTORA: POI **
function Poi (direccion, tipo) {
	return { id: poiIdActual++, direccion: direccion, tipo: tipo };
}

// ** FUNCIÓN CONSTRUCTORA: POIS_HOME **
function PoisHome() {

var self = this;
/* 1) -- POIs como array de Javascript Objets:
var pois = '{ "pois" : [' +
'{ "banco":"BancodelaPlaza", "nombre":"Banco de la Plaza", "direccion":"Paraguay 1135", "sucursal":"Avellaneda", "rangoAtencion":"Lun a Vier 10.00hs a 15.00hs", "palabrasClave":["cobro cheques","depósitos","extracciones","transferencias","créditos"] },' +
	... AGREGAR OTROS CONCATENANDO CON EL '+' ...
]}';
Luego, usar JSON.parse() para convertirlo en un JavaScript object:
	JSON.parse(pois);    */

// 2) -- POIs como array de JSON Objets:
var pois = [
    {"nombre":"Banco de la Plaza",
	"direccion":"Paraguay 1135",
	"sucursal":"Avellaneda",
	"rangoAtencion":"Lun a Vier 10.00hs a 15.00hs",
	"palabrasClave":["cobro cheques","depósitos","extracciones","transferencias","créditos"]
	},
	{"nombre":"CGP Comuna 1",
	"direccion":"Medrano 950",
	"barrios":"Puerto Madero-Retiro-San Nicolás",
	"servicios":["cultura","deportes","turismo"],
	"rangoAtencion":"Lun a Sáb 9.00hs a 13.00hs y 16.30hs a 20.30hs",
	"palabrasClave":["centro de atención","comuna","servicios sociales"]
	},
	{"nombre":"Farmacia Farmacity",
	"direccion":"Corrientes 5081",
	"rubro":"farmacia",
	"rangoAtencion":"Lun a Sáb 8.00hs a 21.00hs",
	"palabrasClave":["comercio","medicamentos","salud","farmacia"]
	},
	{"nombre":"Parada Línea 7",
	"direccion":"Mozart 2300",
	"palabrasClave":["utn","colectivo","lugano","parada"]
	}
]

self.getAll = function () {
	return pois;
};

self.get = function (id) {
	return _.find(pois, { id: id });
	};
};

var pois_app = angular.module("poisApp")
pois_app = factory("PoisHome", function() {
	return new PoisHome();
});