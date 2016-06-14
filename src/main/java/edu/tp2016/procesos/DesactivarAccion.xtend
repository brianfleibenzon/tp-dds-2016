package edu.tp2016.procesos

import edu.tp2016.observersBusqueda.BusquedaObserver
import edu.tp2016.usuarios.Terminal

class DesactivarAccion extends AccionAdministrativa{
	
	new(BusquedaObserver accion){
		accionAsociada = accion
	}

	override doActionOn(Terminal usuario){
		if( !(usuario.busquedaObservers.contains(accionAsociada)) ){
			throw new Exception("Se intenta desactivar una acción que ya está desactivada.")
		}
		else{
			usuario.quitarObserver(accionAsociada) // lo desactiva
		}
	}

}