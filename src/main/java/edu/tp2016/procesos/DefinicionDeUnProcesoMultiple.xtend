package edu.tp2016.procesos

import java.util.List
import java.util.ArrayList

class DefinicionDeUnProcesoMultiple extends Proceso{
	List<Proceso> procesosAnidados = new ArrayList<Proceso>
	
	override ejecutarProceso(){
		procesosAnidados.forEach[ proceso | proceso.ejecutarProceso ]
	}
	
}