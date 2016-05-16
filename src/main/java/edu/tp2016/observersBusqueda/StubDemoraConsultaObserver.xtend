package edu.tp2016.observersBusqueda

import edu.tp2016.observersBusqueda.RegistroDeBusqueda
import org.joda.time.LocalDateTime
import edu.tp2016.servidores.ServidorCentral
import java.util.List
import edu.tp2016.pois.POI
import edu.tp2016.serviciosExternos.Mail
import edu.tp2016.serviciosExternos.MailSender

class StubDemoraConsultaObserver implements BusquedaObserver{
	MailSender mailSender
	
	new(MailSender _mailSender){
	mailSender = _mailSender		
	}
	
	override def void registrarBusqueda(String texto, RegistroDeBusqueda busquedaActual, List<POI> poisDevueltos,
		LocalDateTime inicioBusqueda, LocalDateTime finBusqueda, ServidorCentral servidor){
		
	val demora = (11).longValue()
	
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
		servidor.mailsEnviados = 1
		
		mailSender.sendMail(new Mail(
			servidor.centralMailAdress, servidor.administradorMailAdress, "un mensaje", "un asunto") )

	}
	}