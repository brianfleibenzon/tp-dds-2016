package edu.tp2016.observersBusqueda

import org.joda.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
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
	
	def void registrarCantResult(int cantResult){
		cantidadDeResultados = cantResult
	}
	
	def void registrarTexto(String txt){
		textoBuscado = txt
	}
	
	
	new() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}
