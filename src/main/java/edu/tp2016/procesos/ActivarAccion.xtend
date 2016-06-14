package edu.tp2016.procesos

import edu.tp2016.observersBusqueda.BusquedaObserver
import edu.tp2016.usuarios.Terminal

class ActivarAccion extends AccionAdministrativa{
	
	new(BusquedaObserver accion){
		accionAsociada = accion
	}
	
	override doActionOn(Terminal usuario){
		if( usuario.busquedaObservers.contains(accionAsociada) ){
			throw new Exception("Se intenta activar una acción que ya está activada.")
		}
		else{
			usuario.adscribirObserver(accionAsociada) // lo activa
		}
	}
	
}