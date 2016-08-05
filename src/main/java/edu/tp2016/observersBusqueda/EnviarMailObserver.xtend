package edu.tp2016.observersBusqueda

import java.util.List
import edu.tp2016.pois.POI
import edu.tp2016.serviciosExternos.Mail
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.usuarios.Usuario
import edu.tp2016.buscador.Buscador
import edu.tp2016.serviciosExternos.MailSender

@Accessors
class EnviarMailObserver implements BusquedaObserver {
	String administradorMailAdress
	long timeout
	Usuario user

	new(long _timeout) {
		timeout = _timeout
	}

	override def void registrarBusqueda(String texto, List<POI> poisDevueltos, long demora, Usuario usuario, Buscador buscador) {
		user = usuario
		if (demora >= timeout) {
			enviarMailAlAdministrador(buscador.mailSender)
		}
	}
	
	def boolean enviarMailAlAdministrador(MailSender mailSender) {

		(mailSender).sendMail(new Mail(administradorMailAdress, "un mensaje", "un asunto"))
	}

}
