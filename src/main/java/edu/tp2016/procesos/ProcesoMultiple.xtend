package edu.tp2016.procesos

import java.util.List
import java.util.ArrayList

class ProcesoMultiple extends Proceso{
	List<Proceso> procesosAnidados = new ArrayList<Proceso>
	
	def void anidarProceso(Proceso unProceso){
		procesosAnidados.add(unProceso)
	}
	
	override correr(){
		procesosAnidados.forEach[ proceso | proceso.iniciar(usuarioAdministrador, servidor) ]
	}
	
}