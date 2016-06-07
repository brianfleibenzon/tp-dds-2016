package edu.tp2016.procesos

import edu.tp2016.serviciosExternos.Mail
import edu.tp2016.usuarios.Administrador
import edu.tp2016.servidores.ServidorCentral

class EnviarMail extends Proceso {

	new(Administrador admin, ServidorCentral serv){
		usuarioAdministrador = admin
		servidor = serv		
	}	

	override String correr() {
		servidor.mailSender.sendMail(new Mail(usuarioAdministrador.mailAdress, "un mensaje", "un asunto"))
		
		return "ok"
	}

}
