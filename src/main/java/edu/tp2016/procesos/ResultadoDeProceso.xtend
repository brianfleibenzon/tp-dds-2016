package edu.tp2016.procesos

import org.joda.time.LocalDateTime
import edu.tp2016.usuarios.Administrador
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ResultadoDeProceso {
	LocalDateTime inicioEjecucion
	LocalDateTime finEjecucion
	Proceso procesoEjecutado
	Administrador nombreUsuario
	String resultadoEjecucion
	String mensajeDeError // opcional
	
	
	new(LocalDateTime inicio, LocalDateTime fin, Proceso proceso,
			Administrador usuario, String resultado, String error){
		inicioEjecucion = inicio
		finEjecucion = fin
		procesoEjecutado = proceso
		nombreUsuario = usuario
		resultadoEjecucion = resultado
	}
}