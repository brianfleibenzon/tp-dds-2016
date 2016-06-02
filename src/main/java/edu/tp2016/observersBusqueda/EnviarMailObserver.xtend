package edu.tp2016.observersBusqueda

import edu.tp2016.servidores.ServidorCentral
import java.util.List
import edu.tp2016.pois.POI
import edu.tp2016.serviciosExternos.MailSender
import edu.tp2016.serviciosExternos.Mail
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.usuarios.Terminal

@Accessors
class EnviarMailObserver implements BusquedaObserver {
	String administradorMailAdress
	long timeout

	new(long _timeout) {
		timeout = _timeout
	}

	override def void registrarBusqueda(String texto, List<POI> poisDevueltos, long demora, Terminal terminal,
		ServidorCentral servidor) {
		verificarTiempoDeConsulta(demora, servidor.mailSender)
	}

	def verificarTiempoDeConsulta(long demora, MailSender mailSender) {

		if (demora >= timeout) {
			enviarMail(mailSender)
		}
	}

	def boolean enviarMail(MailSender mailSender) {

		mailSender.sendMail(new Mail(administradorMailAdress, "un mensaje", "un asunto"))
	}

}
