package edu.tp2016.procesos

import edu.tp2016.observersBusqueda.BusquedaObserver
import edu.tp2016.usuarios.Terminal

class ActivarAccion extends AccionAdministrativa{
	
	new(BusquedaObserver accion){
		accionAsociada = accion
	}
	
	override execute(Terminal usuario){
		if( !(usuario.busquedaObservers.contains(accionAsociada)) )
			usuario.adscribirObserver(accionAsociada) // la activa
	}
	
}