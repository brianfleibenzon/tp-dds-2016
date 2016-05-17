package edu.tp2016.observersBusqueda

import edu.tp2016.observersBusqueda.RegistroDeBusqueda
import org.joda.time.LocalDateTime
import org.joda.time.Duration
import edu.tp2016.servidores.ServidorCentral
import java.util.List
import edu.tp2016.pois.POI

class DemoraConsultaObserver implements BusquedaObserver{
	
	override def void registrarBusqueda(String texto, RegistroDeBusqueda busquedaActual, List<POI> poisDevueltos,
		LocalDateTime inicioBusqueda, LocalDateTime finBusqueda, ServidorCentral servidor){
		
	val demora = (new Duration(inicioBusqueda.toDateTime, finBusqueda.toDateTime)).standardSeconds
	
	verificarTiempoDeConsulta(servidor.tiempoLimiteDeBusqueda, demora,
					busquedaActual.sendMail, servidor.administradorMailAdress)
	
	busquedaActual.demoraConsulta = demora
	}
	
	def verificarTiempoDeConsulta(long timeout, long demora, boolean enviaMail, String mailTo){
		
 	if ((demora > timeout) && enviaMail){
 		enviarMail(mailTo)
	}
	}
	
	def enviarMail(String administradorMailAdress){
		// Enviar un mail al Administrador
	}
	
	}