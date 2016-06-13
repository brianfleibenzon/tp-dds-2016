package edu.tp2016.procesos

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class StubProceso extends Proceso{
	
	int vecesEjecutado = 0
	
	override correr(){
		vecesEjecutado++
		throw new Exception("Error de prueba")
	}
}