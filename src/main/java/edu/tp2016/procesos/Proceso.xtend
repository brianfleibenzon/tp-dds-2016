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
	LocalDateTime fin = new LocalDateTime
	Administrador usuarioAdministrador
	ServidorCentral servidor
	public static final boolean OK = true
	public static final boolean ERROR = false
	
	def void iniciar(){
		if (reintentos == 0){
			fin = new LocalDateTime()
			registrarError(inicio, fin, new Exception("Reintentos excedidos"))
		}
		reintentos --
		try{
			this.correr()
			fin = new LocalDateTime()
			registrarExito(inicio, fin)
		}catch(Exception e){
			manejarError(e)
		}
	}
	
	/**
	 * Realiza la ejecución de un proceso y retorna su resultado (ok, error).
	 * 
	 * @param Ninguno
	 * @return OK o ERROR
	 */
	 def ejecutarProceso(){
	 	inicio = new LocalDateTime()
		val resultado = this.correr()
		fin = new LocalDateTime()
		
		if(resultado.equals(OK)){
			// OK: Ejecución correcta
			this.registrarExito(inicio, fin)
		}
		else{
			// ERROR: Ejecución fallida
			iniciar() // TODO: Revisar/adaptar
		}
		
	 }
	 
	def correr(){
	}
	
	def void manejarError(Exception e){
		registrarError(inicio, fin, e)
		if (accionEnCasoDeError != null){
			accionEnCasoDeError.iniciar()
		}		
	}
	
	def void registrarExito(LocalDateTime inicio, LocalDateTime fin){
		usuarioAdministrador.registrarResultado(new ResultadoDeProceso(inicio, fin, this, usuarioAdministrador, OK))
	}
	
	def void registrarError(LocalDateTime inicio, LocalDateTime fin, Exception e){
		usuarioAdministrador.registrarResultado(new ResultadoDeProceso(inicio, fin, this, usuarioAdministrador, ERROR, e.message))
	}
}