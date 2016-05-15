package edu.tp2016.observersBusqueda

import edu.tp2016.servidores.ServidorLocal
import edu.tp2016.observersBusqueda.RegistroDeBusqueda
import org.joda.time.LocalDateTime
import org.joda.time.Duration

class DemoraConsultaObserver implements BusquedaObserver{
	
	override def void registrarBusqueda(String texto, RegistroDeBusqueda busqueda, ServidorLocal servidor){
		
	val LocalDateTime inicioBusqueda = new LocalDateTime()
 	servidor.buscar(texto)
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