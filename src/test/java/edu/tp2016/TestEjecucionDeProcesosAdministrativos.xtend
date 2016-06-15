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
import edu.tp2016.procesos.ActualizacionDeLocalesComerciales
import edu.tp2016.procesos.DarDeBajaUnPOI
import edu.tp2016.procesos.DefinicionDeUnProcesoMultiple

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
	EnviarMailObserver notificacionAlAdministradorAnteDemora
	RegistrarBusquedaObserver registroDeBusqueda
	Administrador administrador
	AgregarAccionesParaTodosLosUsuarios procesoAgregarAcciones
	ActivarAccion activarRegistroDeBusqueda
	DesactivarAccion desactivarRegistroDeBusqueda
	ActivarAccion activarNotificacionAlAdministrador
	DesactivarAccion desactivarNotificacionAlAdministrador
	MailSender mockedMailSender
	DarDeBajaUnPOI procesoDarDeBaja
	DefinicionDeUnProcesoMultiple procesoMultiple
	//Seteos Para Locales Comerciales
	ActualizacionDeLocalesComerciales procesoActualizarLocalComercial

	@Before
	def void setUp() {
		// ¡IMPORTANTE! NO CAMBIAR EL ORDEN DEL SET UP PORQUE SE ROMPEN LOS TESTS
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

		servidorCentral = new ServidorCentral(
			Arrays.asList(utn7parada, utn114parada, miserere7parada, comercioFarmacity, comercioLoDeJuan)) => [
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

		procesoAgregarAcciones = new AgregarAccionesParaTodosLosUsuarios() => [
			// agregarAccionAdministrativa(activarRegistroDeBusqueda)
			agregarAccionAdministrativa(desactivarRegistroDeBusqueda)
			// agregarAccionAdministrativa(activarNotificacionAlAdministrador)
			agregarAccionAdministrativa(desactivarNotificacionAlAdministrador)
		]

		procesoDarDeBaja = new DarDeBajaUnPOI

		procesoActualizarLocalComercial = new ActualizacionDeLocalesComerciales

		procesoMultiple = new DefinicionDeUnProcesoMultiple => [
			anidarProceso(procesoDarDeBaja)
			anidarProceso(procesoActualizarLocalComercial)
		]
		
		administrador = new Administrador(servidorCentral) => [
			agregarProceso(procesoAgregarAcciones)
			agregarProceso(procesoDarDeBaja)
			agregarProceso(procesoActualizarLocalComercial)
			agregarProceso(procesoMultiple)
			
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

	def setUpParaPruebaCompleja() {
		terminalAbasto.quitarObserver(registroDeBusqueda)
		terminalTeatroColon.quitarObserver(registroDeBusqueda)
		terminalFlorida.quitarObserver(notificacionAlAdministradorAnteDemora)

		procesoAgregarAcciones.quitarAccionAdministrativa(desactivarRegistroDeBusqueda)
		procesoAgregarAcciones.quitarAccionAdministrativa(desactivarNotificacionAlAdministrador)
		procesoAgregarAcciones.agregarAccionAdministrativa(activarRegistroDeBusqueda)
		procesoAgregarAcciones.agregarAccionAdministrativa(activarNotificacionAlAdministrador)
	}

	@Test
	def void ejecutarAsignacionDeAccionesYDesahecerEfectos() {

		busquedasEnVariasTerminalesYEnDistintasFechas()

		Assert.assertEquals(12, servidorCentral.busquedas.size)

		verify(mockedMailSender, times(12)).sendMail(any(typeof(Mail)))

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

		Assert.assertTrue(servidorCentral.busquedas.isEmpty)

		verify(mockedMailSender, times(12)).sendMail(any(typeof(Mail))) // Verifico que se haya corrido 0 veces (12 de la anterior prueba)
		servidorCentral.busquedas.clear

		/*  Ahora, el administrador anula los efectos de la asignación de acciones a los usuarios y
		 * 	se verifica que los usuarios vuelvan a poder registrar sus búsquedas  y enviar mails al administrador.
		 */
		administrador.deshacerEfectoDeLaAsignacionDeAcciones()

		busquedasEnVariasTerminalesYEnDistintasFechas()

		Assert.assertEquals(12, servidorCentral.busquedas.size)

		verify(servidorCentral.mailSender, times(24)).sendMail(any(typeof(Mail))) // Verifico que se haya corrido 12 veces (12 de la anterior prueba)
	}

	@Test
	def void ejecutarAsignacionDeAccionesYDeshacerEfectosPruebaMasCompleja() {

		setUpParaPruebaCompleja()
		/* Ahora dos terminales tienen desactivada la acción de registrar las búsquedas
		 * y una terminal la de notificar por mail.
		 * Resultado esperado: de las 12 búsquedas solo se registran las 4 de terminalFlorida
		 * y se envían 8 mails correspondientes a las búsquedas de terminalAbasto y terminalTeatroColon.
		 * */
		busquedasEnVariasTerminalesYEnDistintasFechas()

		Assert.assertEquals(4, servidorCentral.busquedas.size)

		verify(mockedMailSender, times(8)).sendMail(any(typeof(Mail)))

		servidorCentral.busquedas.clear

		/*  La lista de acciones para los usuarios del administrador contiene:
		 * 			- Activar registro de búsquedas
		 * 		y	- Activar notificación por mail durante búsquedas
		 * 
		 * 	El administrador corre el proceso y luego se realizan nuevas búsquedas en las terminales.
		 * 	Resultado esperado: ahora se registran todas las búsquedas y todas las terminales envían mails.
		 */
		administrador.correrProceso(procesoAgregarAcciones)

		busquedasEnVariasTerminalesYEnDistintasFechas()

		Assert.assertEquals(12, servidorCentral.busquedas.size)

		verify(mockedMailSender, times(20)).sendMail(any(typeof(Mail))) // Verifico que se haya corrido 12 veces (8 de la anterior prueba)
		servidorCentral.busquedas.clear

		/*  Ahora, el administrador anula los efectos de la asignación de acciones a los usuarios y
		 * 	se verifica que los usuarios vuelvan a su estado anterior.
		 */
		administrador.deshacerEfectoDeLaAsignacionDeAcciones()

		busquedasEnVariasTerminalesYEnDistintasFechas()

		Assert.assertEquals(4, servidorCentral.busquedas.size)

		verify(servidorCentral.mailSender, times(28)).sendMail(any(typeof(Mail))) // Verifico que se haya corrido 8 veces (20 de la anterior prueba)
	}

	@Test
	def void actualizacionDeLocalComercial() {
		procesoActualizarLocalComercial.textoParaActualizarComercios = "Libreria Juan;fotocopias utiles borrador"
		administrador.correrProceso(procesoActualizarLocalComercial)
		Assert.assertTrue(comercioLoDeJuan.palabrasClave.contains("borrador"))
		Assert.assertFalse(comercioLoDeJuan.palabrasClave.contains("libros"))
	}

	@Test
	def void testDarDeBajaUTN7Parada() {
		utn7parada.id = 1

		administrador.correrProceso(procesoDarDeBaja)
		Assert.assertTrue(servidorCentral.buscarPorId(1).isEmpty())

	}

	@Test
		def void testDarDeBajaUTN114Parada(){
		    utn114parada.id=2
		    
		    administrador.correrProceso(procesoDarDeBaja)
			Assert.assertTrue(servidorCentral.buscarPor("114").isEmpty())
	}
	@Test
	def void testEjecutarProcesoMultiple(){
		utn114parada.id=2
		procesoActualizarLocalComercial.textoParaActualizarComercios = "Libreria Juan;fotocopias utiles borrador"
		
		administrador.correrProceso(procesoMultiple)
		
		Assert.assertTrue(comercioLoDeJuan.palabrasClave.contains("borrador"))
		Assert.assertFalse(comercioLoDeJuan.palabrasClave.contains("lapiz"))		
		Assert.assertTrue(servidorCentral.buscarPor("114").isEmpty())

	}

}
