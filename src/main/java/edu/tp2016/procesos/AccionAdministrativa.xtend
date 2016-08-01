package edu.tp2016.procesos

import edu.tp2016.observersBusqueda.BusquedaObserver
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.usuarios.Terminal

@Accessors
abstract class AccionAdministrativa {
	
	BusquedaObserver accionAsociada

	def execute(Terminal usuario){
	}

}