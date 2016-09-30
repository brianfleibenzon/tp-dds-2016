package edu.tp2016.procesos

import edu.tp2016.serviciosExternos.Mail
import edu.tp2016.usuarios.Administrador
import edu.tp2016.applicationModel.Buscador

class EnviarMail extends Proceso {
	
	override iniciar(Administrador _usuarioAdministrador, Buscador _buscador){
		usuarioAdministrador = _usuarioAdministrador
		buscador = _buscador
		this.correr()
	}

	override correr() {
		buscador.mailSender.sendMail(new Mail(usuarioAdministrador.mailAdress, "un mensaje", "un asunto"))
	}

}
