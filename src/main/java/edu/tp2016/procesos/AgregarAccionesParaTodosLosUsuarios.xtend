package edu.tp2016.procesos

import edu.tp2016.procesos.Proceso
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import edu.tp2016.usuarios.Terminal
import edu.tp2016.servidores.ServidorCentral
import java.util.ArrayList

@Accessors
class AgregarAccionesParaTodosLosUsuarios extends Proceso{
	// Lista de acciones a generar para todos los usuarios del sistema
	List<AccionAdministrativa> accionesAdministrativas = new ArrayList<AccionAdministrativa>
	// Lista de todos los usuarios del sistema
	List<Terminal> usuarios = new ArrayList<Terminal>
	List<Terminal> usuariosBefore = new ArrayList<Terminal>

	new(ServidorCentral _servidor){
		servidor = _servidor
		usuarios.addAll(servidor.terminales)
	}

	/**
	 * Recorre la lista de usuarios y le aplica las acciones administrativas que haya
	 * actualmente definidas.
	 * 
	 * @param Ninguno
	 * @return String resultado de la ejecución
	 */
	override correr() {
		usuarios.forEach [ usuario | usuariosBefore.add(usuario.clone() as Terminal) ]
		usuarios.forEach [ usuario | asignarleAccionesA(usuario) ]
	
		return "ok" // TODO: Ver bien qué y cómo lo devuelve
	}
	
	def asignarleAccionesA(Terminal usuario){
		accionesAdministrativas.map [ accion | accion.applyTo(usuario) ]
	}
	
	def agregarAccionAdministrativa(AccionAdministrativa accion){
		accionesAdministrativas.add(accion)
	}
	
	def deshacerAccionesEnUsuario(Terminal usuarioBefore){
		usuarios.map [ usuario | usuario.copyFrom(usuarioBefore) ]
	}
	
	def undo(){
		usuariosBefore.forEach [ usuarioBefore | deshacerAccionesEnUsuario(usuarioBefore) ]
	}
	
	
	
}