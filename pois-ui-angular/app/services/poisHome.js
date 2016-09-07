var poiIdActual = 1;

// ** FUNCIÓN CONSTRUCTORA: POI **
function Poi(direccion, tipo) {
    return { id: poiIdActual++, direccion: direccion, tipo: tipo };
}

var pois = [{
    id: poiIdActual++,
    nombre: "Banco de la Plaza",
    direccion: "Paraguay 1135",
    tipo: "banco",
    sucursal: "Avellaneda",
    rangoAtencion: "Lun a Vier 10.00hs a 15.00hs",
    palabrasClave: ["cobro cheques", "depósitos", "extracciones", "transferencias", "créditos"]
}, {
    id: poiIdActual++,
    nombre: "Banco Santander Rio",
    direccion: "Av. Corrientes 2682",
    tipo: "banco",
    sucursal: "Caballito",
    rangoAtencion: "Lun a Vier 10.00hs a 15.00hs",
    palabrasClave: ["extracciones", "transferencias"]
}, {
    id: poiIdActual++,
    nombre: "CGP Comuna 1",
    direccion: "Medrano 950",
    tipo: "CGP",
    barrios: "Puerto Madero-Retiro-San Nicolás",
    servicios: ["cultura", "deportes", "turismo"],
    rangoAtencion: "Lun a Sáb 9.00hs a 13.00hs y 16.30hs a 20.30hs",
    palabrasClave: ["cgp", "centro de atención", "comuna", "servicios sociales"]
}, {
    id: poiIdActual++,
    nombre: "Farmacity",
    direccion: "Corrientes 5081",
    tipo: "comercio",
    rubro: "Farmacia",
    rangoAtencion: "Lun a Sáb 8.00hs a 21.00hs",
    palabrasClave: ["comercio", "medicamentos", "salud", "farmacia"]
}, {
    id: poiIdActual++,
    nombre: "El Apunte",
    direccion: "Yatay 260",
    tipo: "comercio",
    rubro: "Libreria",
    rangoAtencion: "Lun a Vie 8.00hs a 21.00hs",
    palabrasClave: ["comercio", "fotocopias", "impresiones", "libreria"]
}, {
    id: poiIdActual++,
    nombre: "Parada Línea 7",
    numero: "7",
    tipo: "parada",
    direccion: "Mozart 2300",
    palabrasClave: ["utn", "colectivo", "lugano", "parada"]
}, {
    id: poiIdActual++,
    nombre: "Parada Línea 114",
    numero: "114",
    tipo: "parada",
    direccion: "Mozart 2300",
    palabrasClave: ["utn", "colectivo", "lugano", "parada"]
}];

// ** FUNCIÓN CONSTRUCTORA: POIS_HOME **
function PoisHome() {

    var self = this;

    self.getAll = function() {
        return pois;
    };

    self.get = function(id) {
        return _.find(pois, { id: id });
    };
};

angular.module("pois-app")
    .factory("PoisHome", function() {
        return new PoisHome();
    });