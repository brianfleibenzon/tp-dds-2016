package edu.tp2016.observersBusqueda

import org.joda.time.LocalDateTime

class RegistroDeBusqueda {

	LocalDateTime fecha
	String terminal
	String textoBuscado
	int cantidadDeResultados
	long demora
	
	new(LocalDateTime _fecha, String _terminal, String busqueda, int resultados, long tiempo){
		fecha = _fecha
		terminal = _terminal
		textoBuscado = busqueda
		cantidadDeResultados = resultados
		demora = tiempo
	}
	
	new() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}
