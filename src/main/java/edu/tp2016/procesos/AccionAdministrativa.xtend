package edu.tp2016.procesos

import edu.tp2016.usuarios.Terminal
import edu.tp2016.observersBusqueda.BusquedaObserver
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class AccionAdministrativa {
	
	BusquedaObserver accionAsociada

	def activarAccionDeUsuario(Terminal usuario){
		usuario.quitarObserver(accionAsociada)
	}
	
	def desactivarAccionDeUsuario(Terminal usuario){
		usuario.adscribirObserver(accionAsociada)
	}
	
	new(BusquedaObserver accion){
		accionAsociada = accion
	}
		
}