package edu.tp2016.serviciosExternos

import edu.tp2016.serviciosExternos.MailSender

class StubMailSender implements MailSender{
	
	override boolean sendMail(Mail mail){
		true
	}
}