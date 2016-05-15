package edu.tp2016.servidorCentral.observers

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
}