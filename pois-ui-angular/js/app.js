'use strict';

var app = angular.module('poisApp', [ ]);

/* Controllers */
app.controller('buscadorCtrl', function () {
	/* scope */
	this.resultados = []; // or null
	this.poiSeleccionado = null;
	this.nuevoCriterio = '';
	this.criteriosBusqueda = [];
	this.initStatus = false;
	this.mensajeInvalido = '';
	this.criterioSeleccionado = '';
	/*-----------------------------------------------------------------------------------*/
	this.repo = null;
	this.busquedas = [];
	//this.usuarioActual = null;
	//this.fechaActual = new Date();
	
	this.buscar = function(texto){
		
		function checkearQuery(texto, poi) {
			texto !== null && (poi.tienePalabraClave(texto) || poi.coincide(texto))
		}
		
		this.repo.filter(checkearQuery.bind(this, checkearQuery))
	}

	this.agregarCriterio = function(){

		if (this.nuevoCriterio !== ''){
			this.criteriosBusqueda.push(nuevoCriterio)
			this.nuevoCriterio = ''
		}
		// else ...
	}

	this.eliminarCriterio = function(){
		this.criteriosBusqueda.pop(this.criterioSeleccionado)
	}

});