package edu.tp2016.serviciosExternos

import edu.tp2016.serviciosExternos.Mail

interface MailSender {
	/**
	 * Servicio externo para el envío de mails.
	 * 
	 * @param mail
	 * @return boolean, true si se envió el mail y false si no se pudo enviar
	 */
	def boolean sendMail(Mail mail)
	
}