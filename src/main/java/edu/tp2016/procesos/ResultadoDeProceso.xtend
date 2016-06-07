package edu.tp2016.procesos

import org.joda.time.LocalDateTime
import edu.tp2016.usuarios.Administrador
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ResultadoDeProceso {
	LocalDateTime inicioEjecucion
	LocalDateTime finEjecucion
	Proceso procesoEjecutado
	Administrador idUsuario
	boolean resultadoEjecucion // OK o ERROR
	String mensajeDeError // opcional
	
	/**
	 * Construye el resultado de ejecución de un proceso incluyendo un mensaje de error.
	 * 
	 * @param
	 * @return resultado de la ejecución de un proceso con mensaje de error
	 */
	new(LocalDateTime inicio, LocalDateTime fin, Proceso proceso,
			Administrador usuario, boolean resultado, String error){
		inicioEjecucion = inicio
		finEjecucion = fin
		procesoEjecutado = proceso
		idUsuario = usuario
		resultadoEjecucion = resultado
		mensajeDeError = error
	}
	
	/**
	 * Construye el resultado de ejecución de un proceso sin incluir un mensaje de error.
	 * 
	 * @param inicio y fin de ejecución, proceso ejecutado, usuario que lo ejecutó, resultado
	 * @return resultado de la ejecución de un proceso
	 */
	new(LocalDateTime inicio, LocalDateTime fin, Proceso proceso,
			Administrador usuario, boolean resultado){
		inicioEjecucion = inicio
		finEjecucion = fin
		procesoEjecutado = proceso
		idUsuario = usuario
		resultadoEjecucion = resultado
	}
}