package edu.tp2016.observersBusqueda

import edu.tp2016.observersBusqueda.RegistroDeBusqueda
import org.joda.time.LocalDateTime
import org.joda.time.Duration
import edu.tp2016.servidores.ServidorCentral
import java.util.List
import edu.tp2016.pois.POI
import edu.tp2016.serviciosExternos.MailSender
import edu.tp2016.serviciosExternos.Mail

class DemoraConsultaObserver implements BusquedaObserver{
	MailSender mailSender
	
	override def void registrarBusqueda(String texto, RegistroDeBusqueda busquedaActual, List<POI> poisDevueltos,
		LocalDateTime inicioBusqueda, LocalDateTime finBusqueda, ServidorCentral servidor){
		
	val demora = (new Duration(inicioBusqueda.toDateTime, finBusqueda.toDateTime)).standardSeconds
	
	verificarTiempoDeConsulta(demora, busquedaActual.sendMail, servidor)
	
	busquedaActual.demoraConsulta = demora
	}
	
	def verificarTiempoDeConsulta(long demora, boolean enviaMail, ServidorCentral servidor){
		
		val limite = servidor.tiempoLimiteDeBusqueda
 	if ((demora > limite) && enviaMail.equals(true)){
 		enviarMail(servidor)
	}
	}
	
	def boolean enviarMail(ServidorCentral servidor){
		mailSender.sendMail(new Mail(
			servidor.centralMailAdress, servidor.administradorMailAdress, "un mensaje", "un asunto")
			)
	}
	
	}