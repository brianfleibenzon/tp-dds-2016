package edu.tp2016.procesos

import java.util.List
import java.util.ArrayList

class DefinicionDeUnProcesoMultiple extends Proceso{
	List<Proceso> procesosAnidados = new ArrayList<Proceso>
	
	override correr(){
		val resultadosProcesos = procesosAnidados.map[ proceso | proceso.correr ]
		val resultado = resultadosProcesos.forall[ resultado | resultado.equals(OK)]
		resultado
	}
	
}