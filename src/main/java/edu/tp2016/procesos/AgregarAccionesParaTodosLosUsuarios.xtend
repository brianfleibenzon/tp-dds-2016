package edu.tp2016.procesos

import edu.tp2016.procesos.Proceso
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import edu.tp2016.usuarios.Terminal
import edu.tp2016.servidores.ServidorCentral
import edu.tp2016.observersBusqueda.BusquedaObserver

@Accessors
class AgregarAccionesParaTodosLosUsuarios extends Proceso{
	
	List<AccionAdministrativa> accionesAdministrativas // Lista de acciones a generar para todos los usuarios del sistema
	List<Terminal> usuarios // Lista de todos los usuarios del sistema
	List<BusquedaObserver> accionesDeUsuario

	new(ServidorCentral _servidor, List<BusquedaObserver> _acciones){
		servidor = _servidor
		accionesDeUsuario.addAll(_acciones)		
	}	

	override correr() {
		usuarios.addAll(servidor.terminales)
		usuarios.forEach [ usuario | ]
	
		return "ok"
	}
	
	def agregarAccionDeUsuario(BusquedaObserver accion){
		accionesDeUsuario.add(accion)
	}
	
	def agregarAccionAdministrativa(AccionAdministrativa accion){
		accionesAdministrativas.add(accion)
	}
	
}