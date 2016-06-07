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
import edu.tp2016.serviciosExternos.MailSender
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*
import edu.tp2016.serviciosExternos.Mail
import edu.tp2016.observersBusqueda.RegistrarBusquedaObserver
import edu.tp2016.observersBusqueda.EnviarMailObserver
import edu.tp2016.usuarios.Terminal

class TestEjecucionDeProcesosAdministrativos {

	Terminal terminalAbasto
	Terminal terminalFlorida
	Terminal terminalTeatroColon
	ServidorCentral servidorCentral
	ServidorCentral mockServidorCentral
	Terminal mockTerminal
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
	
	MailSender mockedMailSender

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

		mockedMailSender = mock(typeof(MailSender))
		
		servidorCentral.mailSender = mockedMailSender

		terminalAbasto = new Terminal(ubicacionX, "terminalAbasto", servidorCentral, fechaDeHoy)
		terminalFlorida = new Terminal(ubicacionX, "terminalFlorida", servidorCentral, fechaDeHoy)
		terminalTeatroColon = new Terminal(ubicacionX, "terminalTeatroColon", servidorCentral, fechaDeHoy)

		terminalAbasto.adscribirObserver(new RegistrarBusquedaObserver)
		terminalAbasto.adscribirObserver(new EnviarMailObserver(5))

		terminalTeatroColon.adscribirObserver(new RegistrarBusquedaObserver)
		terminalTeatroColon.adscribirObserver(new EnviarMailObserver(5))

		terminalFlorida.adscribirObserver(new RegistrarBusquedaObserver)
		terminalFlorida.adscribirObserver(new EnviarMailObserver(5))

		// Setup para mockear demora excedida y envío de mail al administrador:
		mockServidorCentral = new ServidorCentral(Arrays.asList())
		mockServidorCentral.repo.create(utn7parada)
		mockServidorCentral.mailSender = mockedMailSender
		mockTerminal = new Terminal(ubicacionX, "mockTerminal", mockServidorCentral)
		mockTerminal.adscribirObserver(new EnviarMailObserver(0))		
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

	
}