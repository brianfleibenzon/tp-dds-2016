package edu.tp2016

import org.junit.Before
import org.junit.Test
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*
import edu.tp2016.usuarios.Administrador
import edu.tp2016.procesos.StubProceso
import edu.tp2016.servidores.ServidorCentral
import edu.tp2016.serviciosExternos.MailSender
import java.util.ArrayList
import edu.tp2016.pois.POI
import edu.tp2016.serviciosExternos.Mail
import edu.tp2016.procesos.EnviarMail
import org.junit.Assert

class TestErrorEnProceso {
	Administrador unAdministrador
	StubProceso unProceso
	ServidorCentral servidorCentral
	MailSender mockedMailSender
	
	@Before
	def void setUp(){		
		servidorCentral = new ServidorCentral(new ArrayList<POI>)
		unAdministrador = new Administrador(servidorCentral)
		servidorCentral.administradores.add(unAdministrador)
		mockedMailSender = mock(typeof(MailSender))
		servidorCentral.mailSender = mockedMailSender
		unProceso = new StubProceso
		unProceso.servidor = servidorCentral
		unAdministrador.agregarProceso(unProceso)
	}
	
	@Test
	def void testReintentarEjecucionDeProcesoYRegistrarError(){
		unProceso.reintentos = 3
		unAdministrador.correrProceso(unProceso)
		Assert.assertEquals(4, unProceso.vecesEjecutado)
		Assert.assertEquals(false, unAdministrador.resultadosDeEjecucion.get(0).resultadoEjecucion)
	}
	
	@Test
	def void testEnviarMailYRegistrarError(){
		unProceso.reintentos = 0
		unProceso.accionEnCasoDeError = new EnviarMail
		unAdministrador.correrProceso(unProceso)
		Assert.assertEquals(1, unProceso.vecesEjecutado)
		verify(mockedMailSender, times(1)).sendMail(any(typeof(Mail)))	
		Assert.assertEquals(false, unAdministrador.resultadosDeEjecucion.get(0).resultadoEjecucion)	
	}
}