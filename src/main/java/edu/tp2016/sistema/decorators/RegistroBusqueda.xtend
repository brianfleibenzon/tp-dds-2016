package edu.tp2016.sistema.decorators

import org.joda.time.LocalDate
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class RegistroBusqueda {
	LocalDate fecha
	String terminal
	String busqueda
	int resultados
	long tiempo
	
	new(LocalDate _fecha, String _terminal, String _busqueda, int _resultados, long _tiempo){
		fecha = _fecha
		terminal = _terminal
		busqueda = _busqueda
		resultados = _resultados
		tiempo = _tiempo
	}
	
}