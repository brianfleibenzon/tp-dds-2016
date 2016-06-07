package edu.tp2016

import org.junit.Before
import edu.tp2016.servidores.ServidorCentral
import edu.tp2016.mod.Rubro
import edu.tp2016.pois.Comercio
import edu.tp2016.pois.ParadaDeColectivo
import edu.tp2016.mod.DiaDeAtencion
import java.util.List
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
	AgregarAccionesParaTodosLosUsuarios proceso3
	ActivarAccion activarRegistroDeBusqueda
	DesactivarAccion desactivarRegistroDeBusqueda
	ActivarAccion activarNotificacionAlAdministrador
	DesactivarAccion desactivarNotificacionAlAdministrador

	@Before
	def void setUp() {
		ubicacionX = new Point(-1, 1)
		rangoX = Arrays.asList(Lists.newArrayList(unDiaX))
		fechaDeHoy = new LocalDateTime()
		unaFechaPasada = new LocalDateTime(2016, 5, 11, 12, 0)

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

		servidorCentral = new ServidorCentral(Arrays.asList())

		servidorCentral.repo.create(utn7parada)
		servidorCentral.repo.create(utn114parada)
		servidorCentral.repo.create(miserere7parada)
		servidorCentral.repo.create(comercioFarmacity)
		servidorCentral.repo.create(comercioLoDeJuan)

		servidorCentral.interfacesExternas.add(new AdapterBanco(new StubInterfazBanco))
		servidorCentral.interfacesExternas.add(new AdapterCGP(new StubInterfazCGP))

		terminalAbasto = new Terminal(ubicacionX, "terminalAbasto", servidorCentral, fechaDeHoy)
		terminalFlorida = new Terminal(ubicacionX, "terminalFlorida", servidorCentral, fechaDeHoy)
		terminalTeatroColon = new Terminal(ubicacionX, "terminalTeatroColon", servidorCentral, fechaDeHoy)

		notificacionAlAdministradorAnteDemora = new EnviarMailObserver(5)
		registroDeBusqueda = new RegistrarBusquedaObserver()

		terminalAbasto.adscribirObserver(registroDeBusqueda)
		terminalAbasto.adscribirObserver(notificacionAlAdministradorAnteDemora)

		terminalTeatroColon.adscribirObserver(registroDeBusqueda)
		terminalTeatroColon.adscribirObserver(notificacionAlAdministradorAnteDemora)

		terminalFlorida.adscribirObserver(registroDeBusqueda)
		terminalFlorida.adscribirObserver(notificacionAlAdministradorAnteDemora)
		
		// Nuevos seteos para la Entrega 4:
		activarRegistroDeBusqueda = new ActivarAccion(registroDeBusqueda)
		desactivarRegistroDeBusqueda = new DesactivarAccion(registroDeBusqueda)
		activarNotificacionAlAdministrador = new ActivarAccion(notificacionAlAdministradorAnteDemora)
		desactivarNotificacionAlAdministrador = new DesactivarAccion(notificacionAlAdministradorAnteDemora)
		
		proceso3 = new AgregarAccionesParaTodosLosUsuarios(servidorCentral) => [
			agregarAccionAdministrativa(activarRegistroDeBusqueda)
			agregarAccionAdministrativa(desactivarRegistroDeBusqueda)
			agregarAccionAdministrativa(activarNotificacionAlAdministrador)
			agregarAccionAdministrativa(desactivarNotificacionAlAdministrador)
		]
		
		administrador = new Administrador(servidorCentral) => [
			agregarProceso(proceso3)
		]		
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
	def void ejecutarAsignacionDeAcciones() {
		// TODO: Completar
	}
	
	@Test
	def void deshacerEfectosDeEjecutarAsignacionDeAcciones() {
		// TODO: Completar
	}
}