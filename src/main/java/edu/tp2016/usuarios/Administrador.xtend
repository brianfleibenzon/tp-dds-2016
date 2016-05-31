package edu.tp2016.usuarios

import edu.tp2016.procesos.ResultadoDeProceso
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.procesos.Proceso
import edu.tp2016.servidores.ServidorCentral

@Accessors
class Administrador{
	ServidorCentral servidorCentral
	String mailAdress
	List<Proceso> procesosDisponibles
	List<ResultadoDeProceso> resultadosDeEjecucion

	def correrProceso(){
		
	}

}