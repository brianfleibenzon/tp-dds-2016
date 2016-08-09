package edu.tp2016.procesos

import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.usuarios.Administrador
import org.joda.time.LocalDateTime
import edu.tp2016.applicationModel.Buscador

@Accessors
abstract class Proceso {
	
	Proceso accionEnCasoDeError = null
	int reintentos = 0
	LocalDateTime inicio
	LocalDateTime fin
	Administrador usuarioAdministrador
	public static final boolean OK = true
	public static final boolean ERROR = false
	Buscador buscador
	
	/**
	 * Llama a correr() adentro de un try catch.
	 * 
	 */
	def void iniciar(Administrador _usuarioAdministrador, Buscador _buscador){
		usuarioAdministrador = _usuarioAdministrador
		buscador = _buscador
		try{
			inicio = new LocalDateTime()
			this.correr()
			fin = new LocalDateTime()
			registrarExito(inicio, fin)
		}catch(Exception e){
			manejarError(e)
		}
	}
	
	/**
	 * Realiza la ejecución de un proceso. Esta función es privada, para ejecutar
	 * un proceso se debe llamar a iniciar()
	 * 
	 */
	def void correr(){}
	 
	def void manejarError(Exception e){
		if (reintentos == 0){
			if (accionEnCasoDeError != null){
				accionEnCasoDeError.iniciar(usuarioAdministrador, buscador);
			}
			fin = new LocalDateTime()
				registrarError(inicio, fin, e)
		}else{
			reintentos --
			this.iniciar(usuarioAdministrador, buscador)
		}		
	}
	
	def void registrarExito(LocalDateTime inicio, LocalDateTime fin){
		usuarioAdministrador.registrarResultado(new ResultadoDeProceso(inicio, fin, this, usuarioAdministrador, OK))
	}
	
	def void registrarError(LocalDateTime inicio, LocalDateTime fin, Exception e){
		usuarioAdministrador.registrarResultado(new ResultadoDeProceso(inicio, fin, this, usuarioAdministrador, ERROR, e.message))
	}
}