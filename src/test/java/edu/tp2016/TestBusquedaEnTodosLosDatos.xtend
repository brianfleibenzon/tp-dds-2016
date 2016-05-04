package edu.tp2016

import edu.tp2016.interfacesExternas.banco.AdapterBanco
import edu.tp2016.interfacesExternas.banco.StubInterfazBanco
import edu.tp2016.interfacesExternas.cgp.AdapterCGP
import edu.tp2016.interfacesExternas.cgp.StubInterfazCGP
import edu.tp2016.pois.Comercio
import edu.tp2016.pois.ParadaDeColectivo
import java.util.List
import org.joda.time.LocalDateTime
import org.junit.Before
import org.uqbar.geodds.Point
import edu.tp2016.mod.Rubro
import edu.tp2016.mod.DiaDeAtencion
import java.util.Arrays
import com.google.common.collect.Lists
import org.junit.Assert
import org.junit.Test
import edu.tp2016.pois.CGP
import edu.tp2016.pois.Banco

class TestBusquedaEnTodosLosDatos {
	Dispositivo unDispositivo
	Rubro rubroFarmacia
	Rubro rubroLibreria
	Comercio comercioFarmacity
	Comercio comercioLoDeJuan
	ParadaDeColectivo utn7parada
	ParadaDeColectivo miserere7parada
	ParadaDeColectivo utn114parada
	LocalDateTime fechaX
	DiaDeAtencion unDiaX
	Point ubicacionX
	List<DiaDeAtencion> rangoX

	@Before
	def void setUp() {
		ubicacionX = new Point(-1, 1)
		rangoX = Arrays.asList(Lists.newArrayList(unDiaX))
		fechaX = new LocalDateTime()

		utn7parada = new ParadaDeColectivo("7", ubicacionX, Arrays.asList("utn", "campus"))

		miserere7parada = new ParadaDeColectivo("7", ubicacionX, Arrays.asList("utn", "plaza miserere", "once"))

		utn114parada = new ParadaDeColectivo("114", ubicacionX, Arrays.asList("utn", "campus"))

		rubroFarmacia = new Rubro("Farmacia", 1)

		rubroLibreria = new Rubro("Libreria", 2)

		comercioFarmacity = new Comercio("Farmacity", ubicacionX, Arrays.asList("medicamentos", "salud"), rubroFarmacia,
			rangoX)

		comercioLoDeJuan = new Comercio("Libreria Juan", ubicacionX, Arrays.asList("fotocopias", "utiles", "libros"),
			rubroLibreria, rangoX)

		unDispositivo = new Dispositivo(ubicacionX,
			Arrays.asList(utn7parada, miserere7parada, utn114parada, comercioFarmacity, comercioLoDeJuan), fechaX)

		unDispositivo.interfacesExternas.add(new AdapterBanco(new StubInterfazBanco))
		unDispositivo.interfacesExternas.add(new AdapterCGP(new StubInterfazCGP))

	}

	@Test
	def void buscarParadaDeColectivo7() {
		Assert.assertEquals(unDispositivo.buscar("7"), Arrays.asList(utn7parada, miserere7parada))
	}

	@Test
	def void buscarParadaDeColectivo114() {
		Assert.assertEquals(unDispositivo.buscar("114"), Arrays.asList(utn114parada))
	}
	
	@Test
	def void buscarParadaDeColectivoConUnaPalabraClave() {
		Assert.assertEquals(unDispositivo.buscar("campus"), Arrays.asList(utn7parada, utn114parada))
	}

	@Test
	def void buscarComercioPorRubro() {
		Assert.assertEquals(unDispositivo.buscar("libreria"), Arrays.asList(comercioLoDeJuan))
	}

	@Test
	def void buscarComercioPorNombre() {
		Assert.assertEquals(unDispositivo.buscar("farmacity"), Arrays.asList(comercioFarmacity))
	}

	@Test
	def void buscarComercioConUnaPalabraClave() {
		Assert.assertEquals(unDispositivo.buscar("farmacity"), Arrays.asList(comercioFarmacity))
	}

	@Test
	def void buscarCGPConRentas() {
		val resultado = unDispositivo.buscar("Rentas")
		val unCGP = resultado.get(0) as CGP
		Assert.assertEquals(2, unCGP.comuna.numero)
	}

	@Test
	def void buscarCGPConAtencionCiudadana() {
		val resultado = unDispositivo.buscar("Atencion ciudadana")
		val unCGP = resultado.get(0) as CGP
		Assert.assertEquals(3, unCGP.comuna.numero)
	}

	@Test
	def void buscarCGPConVeterinaria() {
		val resultado = unDispositivo.buscar("Veterinaria")
		Assert.assertEquals(0, resultado.size)
	}

	@Test
	def void buscarBancoLlamadoSantanderRio() {
		val bancoEncontrado = (unDispositivo.buscar("Santander Rio")).get(0) as Banco

		Assert.assertEquals("María Luna", bancoEncontrado.nombreGerente)
		Assert.assertTrue(bancoEncontrado.palabrasClave.contains("seguros"))
	}

	@Test
	def void buscarBancoLlamadoBandoDeLaPlazaSucursal2() {
		val bancoEncontrado = (unDispositivo.buscar("Banco de la Plaza")).get(0) as Banco

		Assert.assertEquals("Javier Loeschbor", bancoEncontrado.nombreGerente)
		Assert.assertTrue(bancoEncontrado.palabrasClave.contains("seguros"))
	}

	@Test
	def void buscarBancoLlamadoBandoDeLaPlazaSucursal3() {
		val bancoEncontrado = (unDispositivo.buscar("Banco de la Plaza")).get(1) as Banco

		Assert.assertEquals("Fabian Fataguzzi", bancoEncontrado.nombreGerente)
		Assert.assertTrue(bancoEncontrado.palabrasClave.contains("seguros"))
	}

	@Test
	def void buscarBancoLlamadoBandoaPlazaPorGerenteFabian() {
		val bancosEncontrados = (unDispositivo.buscar("Banco de la Plaza"))
		val bancos = bancosEncontrados.map[banco|banco as Banco]
		bancos.exists[banco|banco.nombreGerente.contains("Fabian Fataguzzi")]

	}

	@Test
	def void buscarBancoLlamadoBandoaPlazaPorSucursalAvellaneda() {
		val bancosEncontrados = (unDispositivo.buscar("Banco de la Plaza"))
		val bancos = bancosEncontrados.map[banco|banco as Banco]
		bancos.exists[banco|banco.sucursal.contains("Avellaneda")]

	}

	@Test
	def void buscarBancoLlamadoBandoaPlazaPorSucursaCaballito() {
		val bancosEncontrados = (unDispositivo.buscar("Banco de la Plaza"))
		val bancos = bancosEncontrados.map[banco|banco as Banco]
		bancos.exists[banco|banco.sucursal.contains("Caballito")]

	}

}
