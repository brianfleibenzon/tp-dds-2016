package edu.tp2016.usuarios

import edu.tp2016.procesos.ResultadoDeProceso
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.procesos.Proceso
import edu.tp2016.servidores.ServidorCentral
import java.util.ArrayList

@Accessors
class Administrador{
	ServidorCentral servidorCentral
	String mailAdress
	List<Proceso> procesosDisponibles = new ArrayList<Proceso>
	List<ResultadoDeProceso> resultadosDeEjecucion = new ArrayList<ResultadoDeProceso>

	def correrProceso(Proceso unProceso){
		val procesoAEjecutar = procesosDisponibles.filter [ proceso | proceso.equals(unProceso)].get(0)
		
		procesoAEjecutar.iniciar()
		
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

}