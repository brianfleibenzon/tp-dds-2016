package edu.tp2016.usuarios

import edu.tp2016.procesos.ResultadoDeProceso
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.procesos.Proceso
import edu.tp2016.servidores.ServidorCentral
import java.util.ArrayList
import edu.tp2016.procesos.AgregarAccionesParaTodosLosUsuarios

@Accessors
class Administrador{
	ServidorCentral servidorCentral
	String mailAdress
	List<Proceso> procesosDisponibles = new ArrayList<Proceso>
	List<ResultadoDeProceso> resultadosDeEjecucion = new ArrayList<ResultadoDeProceso>

	def correrProceso(Proceso unProceso){
		val procesoAEjecutar = procesosDisponibles.filter [ proceso | proceso.equals(unProceso)].get(0)
		
		procesoAEjecutar.iniciar(this, servidorCentral)
		
	}
	
	def registrarResultado(ResultadoDeProceso resultado){
		resultadosDeEjecucion.add(resultado)
	}
	
	new(ServidorCentral servidor){
		servidorCentral = servidor
	}
	
	def agregarProceso(Proceso unProceso){
		unProceso.servidor = servidorCentral
		unProceso.usuarioAdministrador = this
		procesosDisponibles.add(unProceso)
	}
	
	def quitarProceso(Proceso unProceso){
		procesosDisponibles.remove(unProceso)
	}
	
	/**
	 * Busca el proceso correspondiente a la asignación de acciones a los usuarios dentro de la lista
	 * de procesos del administrador. Luego le indica al proceso deshacer sus acciones.
	 * 
	 * @param ninguno
	 * @return vacío
	 */
	def deshacerEfectoDeLaAsignacionDeAcciones(){
		val procesoAEjecutar = procesosDisponibles.filter [ p |
			p.class.equals(AgregarAccionesParaTodosLosUsuarios)].get(0) as AgregarAccionesParaTodosLosUsuarios
		
		procesoAEjecutar.undo()
	}

}