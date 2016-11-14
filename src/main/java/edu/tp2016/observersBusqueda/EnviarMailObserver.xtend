package edu.tp2016.observersBusqueda

import java.util.List
import edu.tp2016.pois.POI
import edu.tp2016.serviciosExternos.Mail
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.usuarios.Usuario
import edu.tp2016.applicationModel.Buscador
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.DiscriminatorValue
import java.util.Set

@Entity
@DiscriminatorValue("2")
@Accessors
class EnviarMailObserver extends BusquedaObserver {
	@Column(length=100)
	String administradorMailAdress
	
	@Column()
	long timeout

	new(long _timeout) {
		timeout = _timeout
	}

	override registrarBusqueda(List<String> criterios, Set<POI> poisDevueltos, long demora, Usuario usuario, Buscador buscador) {
		
		if (demora >= timeout)
			(buscador.mailSender).sendMail(new Mail(administradorMailAdress, "un mensaje", "un asunto"))
	}

}
