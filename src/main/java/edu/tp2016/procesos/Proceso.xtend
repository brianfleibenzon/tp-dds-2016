package edu.tp2016.procesos

import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.usuarios.Administrador
import org.joda.time.LocalDateTime
import edu.tp2016.servidores.ServidorCentral

@Accessors
abstract class Proceso {
	
	Proceso accionEnCasoDeError = null
	int reintentos = 1
	LocalDateTime inicio = new LocalDateTime
	Administrador usuario
	ServidorCentral servidor	
	
	def void iniciar(){
		if (reintentos == 0){
			registrarError(new Exception("Reintentos excedidos"))
		}
		reintentos --
		try{
			this.correr()
			registrarExito()
		}catch(Exception e){
			manejarError(e)
		}
	}
	
	def void correr()
	
	def void manejarError(Exception e){
		registrarError(e)
		if (accionEnCasoDeError != null){
			accionEnCasoDeError.iniciar()
		}		
	}
	
	def void registrarExito(){
		usuario.registrarResultado(new ResultadoDeProceso(inicio, new LocalDateTime, this, usuario, "exito"))
	}
	
	def void registrarError(Exception e){
		usuario.registrarResultado(new ResultadoDeProceso(inicio, new LocalDateTime, this, usuario, "error", e.message))
	}
}