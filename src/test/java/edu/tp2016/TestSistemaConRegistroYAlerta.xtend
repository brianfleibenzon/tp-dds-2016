package edu.tp2016

import edu.tp2016.sistema.Sistema
import org.junit.Before
import org.junit.Test
import org.joda.time.LocalDateTime
import java.util.Arrays
import edu.tp2016.pois.ParadaDeColectivo
import edu.tp2016.pois.Comercio
import edu.tp2016.mod.Rubro
import org.uqbar.geodds.Point
import edu.tp2016.mod.DiaDeAtencion
import java.util.List
import edu.tp2016.serviciosExternos.banco.AdapterBanco
import edu.tp2016.serviciosExternos.cgp.AdapterCGP
import edu.tp2016.serviciosExternos.banco.StubInterfazBanco
import edu.tp2016.serviciosExternos.cgp.StubInterfazCGP
import com.google.common.collect.Lists
import org.junit.Assert
import edu.tp2016.sistema.decorators.SistemaConAlertaAAdministrador
import edu.tp2016.sistema.decorators.SistemaConRegistroDeBusqueda
import edu.tp2016.pois.CGP

class TestSistemaConRegistroYAlerta {
	Sistema unSistema
	SistemaConRegistroDeBusqueda unSistemaConRegistro
	LocalDateTime fechaX
	Rubro rubroFarmacia
	Rubro rubroLibreria
	Comercio comercioFarmacity
	Comercio comercioLoDeJuan
	ParadaDeColectivo utn7parada
	ParadaDeColectivo miserere7parada
	ParadaDeColectivo utn114parada
	DiaDeAtencion unDiaX
	Point ubicacionX
	List<DiaDeAtencion> rangoX

	@Before
	def void setUp() {
		fechaX = new LocalDateTime()

		rangoX = Arrays.asList(Lists.newArrayList(unDiaX))

		utn7parada = new ParadaDeColectivo("7", ubicacionX, Arrays.asList("utn", "campus"))

		miserere7parada = new ParadaDeColectivo("7", ubicacionX, Arrays.asList("utn", "plaza miserere", "once"))

		utn114parada = new ParadaDeColectivo("114", ubicacionX, Arrays.asList("utn", "campus"))

		rubroFarmacia = new Rubro("Farmacia", 1)

		rubroLibreria = new Rubro("Libreria", 2)

		comercioFarmacity = new Comercio("Farmacity", ubicacionX, Arrays.asList("medicamentos", "salud"), rubroFarmacia,
			rangoX)

		comercioLoDeJuan = new Comercio("Libreria Juan", ubicacionX, Arrays.asList("fotocopias", "utiles", "libros"),
			rubroLibreria, rangoX)

		unSistema = new Sistema(Arrays.asList(), fechaX)

		unSistema.repo.create(utn7parada)
		unSistema.repo.create(utn114parada)
		unSistema.repo.create(miserere7parada)
		unSistema.repo.create(comercioFarmacity)
		unSistema.repo.create(comercioLoDeJuan)

		unSistema.interfacesExternas.add(new AdapterBanco(new StubInterfazBanco))
		unSistema.interfacesExternas.add(new AdapterCGP(new StubInterfazCGP))

		unSistemaConRegistro = new SistemaConRegistroDeBusqueda(
			new SistemaConAlertaAAdministrador(unSistema) => [
				timeout = 10
			]
		) => [
			fechaActual = fechaX
		]

		unSistemaConRegistro.terminal = "terminalRetiro"
	}

	@Test
	def void buscarCGPConRentas() {
		val resultado = unSistemaConRegistro.buscar("Rentas")
		val unCGP = resultado.get(0) as CGP
		Assert.assertEquals(2, unCGP.comuna.numero)
	}

	@Test
	def void HacerDosBusquedasYGenerarReporte() {
		unSistemaConRegistro.buscar("utn")
		unSistemaConRegistro.buscar("Rentas")
		unSistemaConRegistro.generarReportePorFecha()
		unSistemaConRegistro.generarReporteTotal()
	}
}
