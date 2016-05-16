package edu.tp2016.observersBusqueda

import edu.tp2016.observersBusqueda.RegistroDeBusqueda
import org.joda.time.LocalDateTime
import org.joda.time.Duration
import edu.tp2016.servidores.ServidorCentral

class DemoraConsultaObserver implements BusquedaObserver{
	
	override def void registrarBusqueda(String texto, RegistroDeBusqueda busquedaActual, ServidorCentral servidor){
		
	val LocalDateTime inicioBusqueda = new LocalDateTime()
 	servidor.buscarPor(texto)
 	// TODO: Para no repetir la búsqueda, este observer podría ser directamente el encargado de hacerla
 	// Se me ocurre como, pero lo vemos después
 	val LocalDateTime finBusqueda = new LocalDateTime()
	val demora = new Duration(inicioBusqueda.toDateTime, finBusqueda.toDateTime).standardSeconds
	verificarTiempoDeConsulta(servidor.tiempoLimiteDeBusqueda, demora) 	
	busquedaActual.demoraConsulta = demora
	}
	
	def verificarTiempoDeConsulta(long timeout, long demora){
		
 	if (demora > timeout){
 		enviarMail()
	}
	}
	
	def enviarMail(){
		// Enviar un mail al Administrador
	}
	
	}