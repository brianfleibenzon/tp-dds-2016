var poiIdActual = 1;

function Poi (direccion, tipo) {
	return { id: poiIdActual++, direccion: direccion, tipo: tipo };
}

/* -- POIs como array de Javascript Objets:

var pois = '{ "pois" : [' +
'{ "banco":"BancodelaPlaza", "nombre":"Banco de la Plaza", "direccion":"Paraguay 1135", "sucursal":"Avellaneda", "rangoAtencion":"Lun a Vier 10.00hs a 15.00hs", "palabrasClave":["cobro cheques","depósitos","extracciones","transferencias","créditos"] },' +
	... AGREGAR OTROS CONCATENANDO CON EL '+' ...
]}';

Luego, usar JSON.parse() para convertirlo en un JavaScript object:
	JSON.parse(pois);    */

// -- POIs como array de JSON Objets:
var pois = [
    {"banco":"BancoDeLaPlaza",
	"nombre":"Banco de la Plaza",
	"direccion":"Paraguay 1135",
	"sucursal":"Avellaneda",
	"rangoAtencion":"Lun a Vier 10.00hs a 15.00hs",
	"palabrasClave":["cobro cheques","depósitos","extracciones","transferencias","créditos"]
	},
	{"cgp":"Comuna1",
	"nombre":"CGP Comuna 1",
	"direccion":"Medrano 950",
	"barrios":"Puerto Madero-Retiro-San Nicolás",
	"servicios":["cultura","deportes","turismo"],
	"rangoAtencion":"Lun a Sáb 9.00hs a 13.00hs y 16.30hs a 20.30hs",
	"palabrasClave":["centro de atención","comuna","servicios sociales"]
	},
	{"comercio":"Farmacity",
	"nombre":"Farmacia Farmacity",
	"direccion":"Corrientes 5081",
	"rubro":"farmacia",
	"rangoAtencion":"Lun a Sáb 8.00hs a 21.00hs",
	"palabrasClave":["comercio","medicamentos","salud","farmacia"]
	},
	{"parada":"7",
	"nombre":"Parada Línea 7",
	"direccion":"Mozart 2300",
	"palabrasClave":["utn","colectivo","lugano","parada"]
	}
]

/*
pois = [
	new Poi("Libertad 1617", { nombre: "Hotel", cantidadEstrellas: 3 } ),
	new Poi("Bulnes 1905", { nombre: "Particular", banios: 2, antiguedad: 15 }),
];*/

function PoisHome() {
	var self = this;

	self.getAll = function () {
		return pois;
	};

	self.get = function (id) {
		return _.find(pois, { id: id });
	};
};

angular.module("pois-app")
.factory("PoisHome", function() {
	return new PoisHome();
});