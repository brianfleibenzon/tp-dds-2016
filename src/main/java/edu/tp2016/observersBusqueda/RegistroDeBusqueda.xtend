package edu.tp2016.observersBusqueda

import org.joda.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors

@ Accessors
class RegistroDeBusqueda {

	LocalDateTime fecha
	String nombreTerminal
	String textoBuscado
	int cantidadDeResultados
	long demoraConsulta
	
	new(LocalDateTime _fecha, String _terminal){
		fecha = _fecha
		nombreTerminal = _terminal
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
