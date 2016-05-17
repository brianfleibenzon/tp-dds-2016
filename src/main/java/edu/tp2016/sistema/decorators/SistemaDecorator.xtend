package edu.tp2016.sistema.decorators

import edu.tp2016.sistema.SistemaInterface
import org.joda.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.sistema.Terminal

@Accessors
abstract class SistemaDecorator implements SistemaInterface{
	
	SistemaInterface sistema
	LocalDateTime fechaActual
	
	override buscar(String texto, Terminal terminal) {
		sistema.buscar(texto, terminal)
	}
	
	new(SistemaInterface _sistema) {
		sistema = _sistema
	}
	
}