package edu.tp2016.observersBusqueda

import edu.tp2016.servidores.ServidorCentral
import java.util.List
import edu.tp2016.pois.POI
import edu.tp2016.serviciosExternos.MailSender
import edu.tp2016.serviciosExternos.Mail
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.servidores.ServidorLocal

@Accessors
class EnviarMailObserver implements BusquedaObserver {
	MailSender mailSender	
	String administradorMailAdress
	String centralMailAdress
	long timeout
	
	new(long _timeout, MailSender _sender) {
		timeout = _timeout
		mailSender = _sender
	}

	override def void registrarBusqueda(String texto, List<POI> poisDevueltos, long demora, ServidorLocal terminal, ServidorCentral servidor){

		verificarTiempoDeConsulta(demora)
		
	}

	def verificarTiempoDeConsulta(long demora) {

		if (demora >= timeout) {
			enviarMail()
		}
	}

	def boolean enviarMail() {
		mailSender.sendMail(
			new Mail(centralMailAdress, administradorMailAdress, "un mensaje", "un asunto")
		)
	}

}
