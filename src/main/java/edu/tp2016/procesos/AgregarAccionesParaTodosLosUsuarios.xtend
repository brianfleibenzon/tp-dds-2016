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
	// Usuarios del sistema:
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
	 * @param ninguno
	 * @return vacío
	 */
	override correr() {
		usuarios.forEach [ usuario |
		
			usuariosBefore.add( usuario.clonar() ) // clono el estado actual del usuario
			
			asignarleAccionesA(usuario)
		]
	}
	
	/**
	 * Le aplica todas las acciones de la lista de acciones del administrador a un
	 * determinado usuario.
	 * 
	 * @return vacío
	 */
	def void asignarleAccionesA(Terminal usuario){
		accionesAdministrativas.forEach [ accion | accion.doActionOn(usuario) ]
	}
	
	def agregarAccionAdministrativa(AccionAdministrativa accion){
		accionesAdministrativas.add(accion)
	}
	
	def agregarAccionesAdministrativas(List<AccionAdministrativa> acciones){
		accionesAdministrativas.addAll(acciones)
	}
	
	/**
	 * Deshace la asignación de acciones en los usuarios. Requiere una clonación del estado
	 * anterior de los usuarios previa a la ejecución del proceso. Luego, para cada usuario
	 * se realiza una copia del estado estado anterior clonado en su estado actual. 
	 * 
	 * @param ninguno
	 * @return vacío
	 */
	def undo(){
		usuarios.forEach [ usuario |
			val usuarioBefore = obtenerUsuarioBefore(usuario)
			usuario.copyFrom(usuarioBefore)
		]
	}
	
	def Terminal obtenerUsuarioBefore(Terminal usuario){
		(usuariosBefore.filter [ usuarioBefore | usuarioBefore.nombreTerminal.equals(usuario.nombreTerminal)]).get(0)
	}
	
	/**
	 *Deshace la asignación de acciones en los usuarios. No requiere una clonación del estado
	 * anterior de los usuarios, sino que aplica la operación inversa de la acción administrativa
	 * aplicada:
	 * activar->desactivar, y, desactivar->activar
	 * 
	 * @param ninguno
	 * @return vacío
	 */
	/*def undo_version2(){
		usuarios.forEach [ usuario | deshacerAsignacionDeAcciones(usuario) ]
	}
	
	def deshacerAsignacionDeAcciones(Terminal usuario){
		accionesAdministrativas.map [ accion | accion.undoAction(usuario) ]
	}*/
	
}