package edu.tp2016.usuarios

import edu.tp2016.procesos.ResultadoDeProceso
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.procesos.Proceso
import java.util.ArrayList
import edu.tp2016.procesos.AgregarAccionesParaTodosLosUsuarios
import edu.tp2016.buscador.Buscador

@Accessors
class Administrador extends Usuario {
	List<Proceso> procesosDisponibles = new ArrayList<Proceso>
	List<ResultadoDeProceso> resultadosDeEjecucion = new ArrayList<ResultadoDeProceso>
	
	new(String nombre) {
		userName = nombre
	}
	
	new(String nombre, String contraseña) {
		userName = nombre
		password = contraseña
	} // Constructor para el Login

	def correrProceso(Proceso unProceso, Buscador buscador){
		val procesoAEjecutar = procesosDisponibles.filter [ proceso | proceso.equals(unProceso)].get(0)
		
		procesoAEjecutar.iniciar(this, buscador)
		
	}
	
	def registrarResultado(ResultadoDeProceso resultado){
		resultadosDeEjecucion.add(resultado)
	}
	
	def agregarProceso(Proceso unProceso){
		unProceso.usuarioAdministrador = this
		procesosDisponibles.add(unProceso)
	}
	
	def quitarProceso(Proceso unProceso){
		procesosDisponibles.remove(unProceso)
	}
	
	/**
	 * Busca el proceso correspondiente a la asignación de acciones a los usuarios dentro de la lista
	 * de procesos del administrador. Luego le indica al proceso deshacer sus acciones.
	 */
	def deshacerEfectoDeLaAsignacionDeAcciones(){
		val procesoAEjecutar = procesosDisponibles.filter [ p |
			p instanceof AgregarAccionesParaTodosLosUsuarios ].get(0) as AgregarAccionesParaTodosLosUsuarios
		
		procesoAEjecutar.undo()
	}

}