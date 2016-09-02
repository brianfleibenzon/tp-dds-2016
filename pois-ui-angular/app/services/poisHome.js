var poiIdActual = 1;

function Poi (direccion, tipo) {
	return { id: poiIdActual++, direccion: direccion, tipo: tipo };
}

pois = [
	new Poi("Libertad 1617", { nombre: "Hotel", cantidadEstrellas: 3 } ),
	new Poi("Bulnes 1905", { nombre: "Particular", banios: 2, antiguedad: 15 }),
];

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