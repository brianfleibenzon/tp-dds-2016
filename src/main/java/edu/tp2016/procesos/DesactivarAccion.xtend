package edu.tp2016.procesos

import edu.tp2016.observersBusqueda.BusquedaObserver
import edu.tp2016.usuarios.Terminal

class DesactivarAccion extends AccionAdministrativa{
	
	new(BusquedaObserver accion){
		accionAsociada = accion
	}

	override doAction(Terminal usuario){
		usuario.quitarObserver(accionAsociada)
	}
	
	override undoAction(Terminal usuario){
		usuario.adscribirObserver(accionAsociada)
	}
}