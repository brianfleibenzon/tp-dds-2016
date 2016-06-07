package edu.tp2016.procesos

import edu.tp2016.procesos.Proceso
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import edu.tp2016.usuarios.Terminal
import edu.tp2016.servidores.ServidorCentral
import java.util.ArrayList

@Accessors
class AgregarAccionesParaTodosLosUsuarios extends Proceso{
	// Lista de acciones a generar para todos los usuarios del sistema:
	List<AccionAdministrativa> accionesAdministrativas = new ArrayList<AccionAdministrativa>
	// Lista de todos los usuarios del sistema:
	List<Terminal> usuarios = new ArrayList<Terminal>
	// Lista de las clonaciones de los usuarios antes de la ejecución:
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
	
		return OK
	}
	
	def asignarleAccionesA(Terminal usuario){
		accionesAdministrativas.map [ accion | accion.doAction(usuario) ]
	}
	
	def deshacerAsignacionDeAcciones(Terminal usuario){
		accionesAdministrativas.map [ accion | accion.undoAction(usuario) ]
	}
	
	def agregarAccionAdministrativa(AccionAdministrativa accion){
		accionesAdministrativas.add(accion)
	}
	
	def deshacerAccionesEnUsuario(Terminal usuarioBefore){
		usuarios.map [ usuario | usuario.copyFrom(usuarioBefore) ]
	}
	
	/**
	 * Deshace la asignación de acciones en los usuarios. Requiere una clonación del estado
	 * anterior de los usuarios, previa a la ejecución del proceso. Luego, para cada usuario
	 * se realiza una copia del estado estado anterior clonado en su estado actual. 
	 * 
	 * @param Ninguno
	 * @return Vacío
	 */
	def undo_version1(){
		usuariosBefore.forEach [ usuarioBefore | deshacerAccionesEnUsuario(usuarioBefore) ]
	}
	
	/**
	 *Deshace la asignación de acciones en los usuarios. No requiere una clonación del estado
	 * anterior de los usuarios, sino que aplica la operación inversa de la acción administrativa
	 * aplicada:
	 * activar->desactivar, y, desactivar->activar
	 * 
	 * @param Ninguno
	 * @return Vacío
	 */
	def undo_version2(){
		usuarios.forEach [ usuario | deshacerAsignacionDeAcciones(usuario) ]
	}
	
}