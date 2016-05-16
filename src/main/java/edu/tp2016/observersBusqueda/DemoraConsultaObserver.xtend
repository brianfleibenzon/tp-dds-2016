package edu.tp2016.observersBusqueda

import edu.tp2016.observersBusqueda.RegistroDeBusqueda
import org.joda.time.LocalDateTime
import org.joda.time.Duration
import edu.tp2016.servidores.ServidorCentral

class DemoraConsultaObserver implements BusquedaObserver{
	
	override def void registrarBusqueda(String texto, RegistroDeBusqueda busqueda, ServidorCentral servidor){
		
	val LocalDateTime inicioBusqueda = new LocalDateTime()
 	servidor.buscarPor(texto)
 	// TODO: Para no repetir la búsqueda, este observer podría ser directamente el encargado de hacerla
 	// Se me ocurre como, pero lo vemos después
 	val LocalDateTime finBusqueda = new LocalDateTime()

	verificarTiempoDeConsulta(servidor.tiempoLimiteDeBusqueda, inicioBusqueda, finBusqueda) 	
 	
	}
	
	def verificarTiempoDeConsulta(long timeout, LocalDateTime inicio, LocalDateTime fin){
		val demora = new Duration(inicio.toDateTime, fin.toDateTime).standardSeconds
 	if (demora > timeout){
 		enviarMail()
	}
	}
	
	def enviarMail(){
		// Enviar un mail al Administrador
	}
	
	}