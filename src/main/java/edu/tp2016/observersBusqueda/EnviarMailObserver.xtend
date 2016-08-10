package edu.tp2016.observersBusqueda

import java.util.List
import edu.tp2016.pois.POI
import edu.tp2016.serviciosExternos.Mail
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.usuarios.Usuario
import edu.tp2016.applicationModel.Buscador

@Accessors
class EnviarMailObserver implements BusquedaObserver {
	String administradorMailAdress
	long timeout

	new(long _timeout) {
		timeout = _timeout
	}

	override registrarBusqueda(List<String> criterios, List<POI> poisDevueltos, long demora, Usuario usuario, Buscador buscador) {
		
		if (demora >= timeout)
			(buscador.mailSender).sendMail(new Mail(administradorMailAdress, "un mensaje", "un asunto"))
	}

}
