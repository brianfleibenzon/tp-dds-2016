package edu.tp2016.procesos

import edu.tp2016.procesos.Proceso
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import edu.tp2016.usuarios.Terminal
import java.util.ArrayList

@Accessors
class AgregarAccionesParaTodosLosUsuarios extends Proceso{
	// Lista de acciones a generar para todos los usuarios del sistema:
	List<AccionAdministrativa> accionesAdministrativas = new ArrayList<AccionAdministrativa>
	// Usuarios del sistema:
	List<Terminal> usuarios = new ArrayList<Terminal>
	// Lista de las clonaciones de los usuarios antes de la ejecución:
	List<Terminal> usuariosBefore = new ArrayList<Terminal>

	/**
	 * Recorre la lista de usuarios y le aplica las acciones administrativas que haya
	 * actualmente definidas.
	 * 
	 * @param ninguno
	 * @return vacío
	 */
	override correr() {
		usuarios.clear
		
			usuarios.addAll(servidor.terminales)

		usuariosBefore.clear
		
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
		accionesAdministrativas.forEach [ accion | accion.execute(usuario) ]
	}
	
	def agregarAccionAdministrativa(AccionAdministrativa accion){
		accionesAdministrativas.add(accion)
	}
	
	def quitarAccionAdministrativa(AccionAdministrativa accion){
		accionesAdministrativas.remove(accion)
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
	
}