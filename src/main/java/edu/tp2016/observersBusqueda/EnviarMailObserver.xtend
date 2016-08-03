package edu.tp2016.observersBusqueda

import java.util.List
import edu.tp2016.pois.POI
import edu.tp2016.serviciosExternos.Mail
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.usuarios.Terminal

@Accessors
class EnviarMailObserver implements BusquedaObserver {
	String administradorMailAdress
	long timeout
	Terminal terminal

	new(long _timeout) {
		timeout = _timeout
	}

	override def void registrarBusqueda(String texto, List<POI> poisDevueltos, long demora, Terminal unaTerminal) {
		terminal = unaTerminal
		if (demora >= timeout) {
			enviarMailAlAdministrador()
		}
	}
	
	def boolean enviarMailAlAdministrador() {

		(terminal.mailSender).sendMail(new Mail(administradorMailAdress, "un mensaje", "un asunto"))
	}

}
