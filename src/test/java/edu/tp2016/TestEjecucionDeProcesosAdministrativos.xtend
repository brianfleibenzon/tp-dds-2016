package edu.tp2016

import org.junit.Before
import edu.tp2016.servidores.ServidorCentral
import edu.tp2016.mod.Rubro
import edu.tp2016.pois.Comercio
import edu.tp2016.pois.ParadaDeColectivo
import edu.tp2016.mod.DiaDeAtencion
import java.util.List
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*
import java.util.Arrays
import org.joda.time.LocalDateTime
import com.google.common.collect.Lists
import org.uqbar.geodds.Point
import edu.tp2016.serviciosExternos.banco.AdapterBanco
import edu.tp2016.serviciosExternos.cgp.StubInterfazCGP
import edu.tp2016.serviciosExternos.banco.StubInterfazBanco
import edu.tp2016.serviciosExternos.cgp.AdapterCGP
import org.junit.Assert
import org.junit.Test
import edu.tp2016.builder.ParadaBuilder
import edu.tp2016.builder.ComercioBuilder
import edu.tp2016.observersBusqueda.RegistrarBusquedaObserver
import edu.tp2016.observersBusqueda.EnviarMailObserver
import edu.tp2016.usuarios.Terminal
import edu.tp2016.usuarios.Administrador
import edu.tp2016.procesos.AgregarAccionesParaTodosLosUsuarios
import edu.tp2016.procesos.ActivarAccion
import edu.tp2016.procesos.DesactivarAccion
import edu.tp2016.serviciosExternos.MailSender
import edu.tp2016.serviciosExternos.Mail

class TestEjecucionDeProcesosAdministrativos {

	Terminal terminalAbasto
	Terminal terminalFlorida
	Terminal terminalTeatroColon
	ServidorCentral servidorCentral
	Rubro rubroFarmacia
	Rubro rubroLibreria
	Comercio comercioFarmacity
	Comercio comercioLoDeJuan
	ParadaDeColectivo utn7parada
	ParadaDeColectivo miserere7parada
	ParadaDeColectivo utn114parada
	LocalDateTime fechaDeHoy
	LocalDateTime unaFechaPasada
	DiaDeAtencion unDiaX
	Point ubicacionX
	List<DiaDeAtencion> rangoX
	
	// Nuevos seteos para la Entrega 4:
	EnviarMailObserver notificacionAlAdministradorAnteDemora
	RegistrarBusquedaObserver registroDeBusqueda
	Administrador administrador
	AgregarAccionesParaTodosLosUsuarios procesoAgregarAcciones
	ActivarAccion activarRegistroDeBusqueda
	DesactivarAccion desactivarRegistroDeBusqueda
	ActivarAccion activarNotificacionAlAdministrador
	DesactivarAccion desactivarNotificacionAlAdministrador
	MailSender mockedMailSender

	@Before
	def void setUp() {
		// ¡IMPORTANTE! NO CAMBIAR EL ORDEN DEL SET UP PORQUE SE ROMPE TODO :)
		ubicacionX = new Point(-1, 1)
		rangoX = Arrays.asList(Lists.newArrayList(unDiaX))
		fechaDeHoy = new LocalDateTime()
		unaFechaPasada = new LocalDateTime(2016, 5, 11, 12, 0)

		// Set up de POIs:
		utn7parada = new ParadaBuilder().nombre("7").ubicacion(ubicacionX).claves(Arrays.asList("utn", "campus")).build
		miserere7parada = new ParadaBuilder().nombre("7").ubicacion(ubicacionX).claves(
			Arrays.asList("utn", "plaza miserere", "once")).build
		utn114parada = new ParadaBuilder().nombre("114").ubicacion(ubicacionX).claves(Arrays.asList("utn", "campus")).
			build
		rubroFarmacia = new Rubro("Farmacia", 1)
		rubroLibreria = new Rubro("Libreria", 2)
		comercioFarmacity = new ComercioBuilder().nombre("Farmacity").ubicacion(ubicacionX).claves(
			Arrays.asList("medicamentos", "salud")).rubro(rubroFarmacia).rango(rangoX).build
		comercioLoDeJuan = new ComercioBuilder().nombre("Libreria Juan").ubicacion(ubicacionX).claves(
			Arrays.asList("fotocopias", "utiles", "libros")).rubro(rubroLibreria).rango(rangoX).build

		notificacionAlAdministradorAnteDemora = new EnviarMailObserver(-1) // le seteo un timeout negativo para que siempre mande mail
		registroDeBusqueda = new RegistrarBusquedaObserver()
		
		activarRegistroDeBusqueda = new ActivarAccion(registroDeBusqueda)
		desactivarRegistroDeBusqueda = new DesactivarAccion(registroDeBusqueda)
		activarNotificacionAlAdministrador = new ActivarAccion(notificacionAlAdministradorAnteDemora)
		desactivarNotificacionAlAdministrador = new DesactivarAccion(notificacionAlAdministradorAnteDemora)
		
		mockedMailSender = mock(typeof(MailSender))
		
		servidorCentral = new ServidorCentral(Arrays.asList(
			utn7parada,utn114parada,miserere7parada,comercioFarmacity,comercioLoDeJuan)) => [
			interfacesExternas.add(new AdapterBanco(new StubInterfazBanco))
			interfacesExternas.add(new AdapterCGP(new StubInterfazCGP))
			mailSender = mockedMailSender
		]
		
		// Set up de Terminales:
		terminalAbasto = new Terminal(ubicacionX, "terminalAbasto", servidorCentral, fechaDeHoy)
		terminalFlorida = new Terminal(ubicacionX, "terminalFlorida", servidorCentral, fechaDeHoy)
		terminalTeatroColon = new Terminal(ubicacionX, "terminalTeatroColon", servidorCentral, fechaDeHoy)
		
		terminalAbasto.adscribirObserver(registroDeBusqueda)
		terminalAbasto.adscribirObserver(notificacionAlAdministradorAnteDemora)
		terminalTeatroColon.adscribirObserver(registroDeBusqueda)
		terminalTeatroColon.adscribirObserver(notificacionAlAdministradorAnteDemora)
		terminalFlorida.adscribirObserver(registroDeBusqueda)
		terminalFlorida.adscribirObserver(notificacionAlAdministradorAnteDemora)
		
		procesoAgregarAcciones = new AgregarAccionesParaTodosLosUsuarios(servidorCentral) => [
			//agregarAccionAdministrativa(activarRegistroDeBusqueda)
			agregarAccionAdministrativa(desactivarRegistroDeBusqueda)
			//agregarAccionAdministrativa(activarNotificacionAlAdministrador)
			agregarAccionAdministrativa(desactivarNotificacionAlAdministrador)
		]
		
		administrador = new Administrador(servidorCentral) => [
			agregarProceso(procesoAgregarAcciones)
		]		
		
		servidorCentral.administradores.add(administrador)
	}

	def busquedasEnVariasTerminalesYEnDistintasFechas() {
		terminalAbasto.buscar("114") // encuentra
		terminalAbasto.buscar("Banco Nacion") // no encuentra
		terminalFlorida.buscar("plaza miserere") // encuentra
		terminalFlorida.buscar("Libreria Juan") // encuentra
		terminalTeatroColon.buscar("seguros") // encuentra
		terminalTeatroColon.buscar("plaza miserere") // encuentra
		terminalAbasto.fechaActual = unaFechaPasada
		terminalFlorida.fechaActual = unaFechaPasada
		terminalTeatroColon.fechaActual = unaFechaPasada
		terminalAbasto.buscar("Banco de la Plaza") // encuentra
		terminalAbasto.buscar("utn") // encuentra
		terminalFlorida.buscar("Farmacity") // encuentra
		terminalFlorida.buscar("facultad de medicina") // no encuentra 
		terminalTeatroColon.buscar("Atencion ciudadana") // encuentra
		terminalTeatroColon.buscar("cine") // no encuentra
		// En total 12 terminales
	}

	@Test
	def void ejecutarAsignacionDeAccionesPruebaParaRegistroDeBusquedas() {
		
		busquedasEnVariasTerminalesYEnDistintasFechas()
		
		Assert.assertEquals( 12, servidorCentral.busquedas.size )
		
		servidorCentral.busquedas.clear
		
		/*  La lista de acciones para los usuarios del administrador contiene:
		 * 			- Desactivar registro de búsquedas
		 * 		y	- Desactivar notificación por mail durante búsquedas
		 * 
		 * 	El administrador corre el proceso y luego se realizan nuevas búsquedas en las terminales.
		 * 	Resultado esperado: no se registra ninguna búsqueda y no se envía ningún mail (por más que haya demora).
		 */
		
		administrador.correrProceso(procesoAgregarAcciones)
		
		busquedasEnVariasTerminalesYEnDistintasFechas()
		
		Assert.assertTrue( servidorCentral.busquedas.isEmpty )
		
		servidorCentral.busquedas.clear
		
		/*  Ahora, el administrador anula los efectos de la asignación de acciones a los usuarios y
		 * 	se verifica que los usuarios vuelvan a poder registrar sus búsquedas.
		 */
		 
		administrador.deshacerEfectoDeLaAsignacionDeAcciones()
		
		busquedasEnVariasTerminalesYEnDistintasFechas()
		
		Assert.assertEquals( 12, servidorCentral.busquedas.size )
	}
	
	@Test
	def void ejecutarAsignacionDeAccionesPruebaParaNotificacionPorMail() {
		
		busquedasEnVariasTerminalesYEnDistintasFechas()
		
		verify(servidorCentral.mailSender, times(12)).sendMail(any(typeof(Mail)))
		
		/*  La lista de acciones para los usuarios del administrador contiene:
		 * 			- Desactivar registro de búsquedas
		 * 		y	- Desactivar notificación por mail durante búsquedas
		 * 
		 * 	El administrador corre el proceso y luego se realizan nuevas búsquedas en las terminales.
		 * 	Resultado esperado: no se registra ninguna búsqueda y no se envía ningún mail (por más que haya demora).
		 */
		
		administrador.correrProceso(procesoAgregarAcciones)
		
		busquedasEnVariasTerminalesYEnDistintasFechas()
		
		verify(servidorCentral.mailSender, times(0)).sendMail(any(typeof(Mail)))
		
		/*  Ahora, el administrador anula los efectos de la asignación de acciones a los usuarios y
		 * 	se verifica que los usuarios vuelvan a poder registrar sus búsquedas y enviar mails al administrador.
		 */
		 
		administrador.deshacerEfectoDeLaAsignacionDeAcciones()
		
		busquedasEnVariasTerminalesYEnDistintasFechas()
		
		verify(servidorCentral.mailSender, times(12)).sendMail(any(typeof(Mail)))
	}

}