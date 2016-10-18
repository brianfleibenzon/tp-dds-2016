package edu.tp2016

import com.google.common.collect.Lists
import edu.tp2016.applicationModel.Buscador
import edu.tp2016.builder.ComercioBuilder
import edu.tp2016.builder.ParadaBuilder
import edu.tp2016.mod.DiaDeAtencion
import edu.tp2016.mod.Punto
import edu.tp2016.mod.Rubro
import edu.tp2016.pois.Banco
import edu.tp2016.pois.CGP
import edu.tp2016.pois.Comercio
import edu.tp2016.pois.POI
import edu.tp2016.pois.ParadaDeColectivo
import edu.tp2016.repositorio.RepoPois
import edu.tp2016.serviciosExternos.banco.AdapterBanco
import edu.tp2016.serviciosExternos.banco.StubInterfazBanco
import edu.tp2016.serviciosExternos.cgp.AdapterCGP
import edu.tp2016.serviciosExternos.cgp.StubInterfazCGP
import edu.tp2016.usuarios.Terminal
import java.util.ArrayList
import java.util.Arrays
import java.util.List
import java.util.Set
import org.joda.time.LocalDateTime
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestBusquedaEnTodosLosDatos {
	Buscador buscador
	Rubro rubroFarmacia
	Rubro rubroLibreria
	Comercio comercioFarmacity
	Comercio comercioLoDeJuan
	ParadaDeColectivo utn7parada
	ParadaDeColectivo miserere7parada
	ParadaDeColectivo utn114parada
	LocalDateTime fechaX
	Punto ubicacionX
	ArrayList<POI> pois

	@Before
	def void setUp() {
		ubicacionX = new Punto(-1, 1)
		fechaX = new LocalDateTime()

		utn7parada = new ParadaBuilder().nombre("7").ubicacion(ubicacionX).claves(Arrays.asList("utn", "campus")).build

		miserere7parada = new ParadaBuilder().nombre("7").ubicacion(ubicacionX).claves(
			Arrays.asList("utn", "plaza miserere", "once")).build

		utn114parada = new ParadaBuilder().nombre("114").ubicacion(ubicacionX).claves(Arrays.asList("utn", "campus")).
			build

		rubroFarmacia = new Rubro("Farmacia", 1)

		rubroLibreria = new Rubro("Libreria", 2)

		comercioFarmacity = new ComercioBuilder().nombre("Farmacity").ubicacion(ubicacionX).claves(
			Arrays.asList("medicamentos", "salud")).rubro(rubroFarmacia).rango(Lists.newArrayList(new DiaDeAtencion())).
			build

		comercioLoDeJuan = new ComercioBuilder().nombre("Libreria Juan").ubicacion(ubicacionX).claves(
			Arrays.asList("fotocopias", "utiles", "libros")).rubro(rubroLibreria).rango(
			Lists.newArrayList(new DiaDeAtencion())).build

		pois = Lists.newArrayList(utn7parada, utn114parada, miserere7parada, comercioFarmacity, comercioLoDeJuan)

		buscador = new Buscador() => [
			interfacesExternas.addAll(new AdapterBanco(new StubInterfazBanco), new AdapterCGP(new StubInterfazCGP))
			repo = RepoPois.instance
			repo.borrarDatos();
			repo.agregarVariosPois(pois)
			usuarioActual = new Terminal("terminal")
		]
	}

	@After
	def void finalizar() {
		RepoPois.instance.borrarDatos()
	}

	def boolean coinciden(Set<POI> resultado, List<POI> esperado) {
		resultado.size == esperado.size && esperado.forall[poi|resultado.exists[it.id == poi.id]]
	}

	@Test
	def void buscarParadaDeColectivo7() {
		Assert.assertTrue(coinciden(buscador.buscar("7"), Arrays.asList(utn7parada, miserere7parada)))
	}

	@Test
	def void buscarParadaDeColectivo114() {
		Assert.assertTrue(coinciden(buscador.buscar("114"), Arrays.asList(utn114parada)))
	}

	@Test
	def void buscarParadaDeColectivoConUnaPalabraClave() {
		Assert.assertTrue(coinciden(buscador.buscar("campus"), Arrays.asList(utn7parada, utn114parada)))
	}

	@Test
	def void buscarComercioPorRubro() {
		Assert.assertTrue(coinciden(buscador.buscar("libreria"), Arrays.asList(comercioLoDeJuan)))
	}

	@Test
	def void buscarComercioPorNombre() {
		Assert.assertTrue(coinciden(buscador.buscar("farmacity"), Arrays.asList(comercioFarmacity)))
	}

	@Test
	def void buscarComercioConUnaPalabraClave() {
		Assert.assertTrue(coinciden(buscador.buscar("farmacity"), Arrays.asList(comercioFarmacity)))
	}

	@Test
	def void buscarCGPConRentas() {
		val resultado = buscador.buscar("Rentas")
		val unCGP = resultado.get(0) as CGP
		Assert.assertEquals(2, unCGP.comuna.numero)
	}

	@Test
	def void buscarCGPConAtencionCiudadana() {
		val resultado = buscador.buscar("Atencion ciudadana")
		val unCGP = resultado.get(0) as CGP
		Assert.assertEquals(3, unCGP.comuna.numero)
	}

	@Test
	def void buscarCGPConVeterinaria() {
		val resultado = buscador.buscar("Veterinaria")
		Assert.assertEquals(0, resultado.size)
	}

	@Test
	def void buscarBancoLlamadoSantanderRío() {
		val bancoEncontrado = (buscador.buscar("Santander Rio")).get(0) as Banco

		Assert.assertEquals("María Luna", bancoEncontrado.nombreGerente)
		Assert.assertTrue(bancoEncontrado.palabrasClave.contains("seguros"))
	}

	@Test
	def void buscarBancoLlamadoBancoDeLaPlazaYVerSiEstáSucursalAvellaneda() {
		val resultadoBusqueda = buscador.buscar("Banco de la Plaza")
		val bancosEncontrados = resultadoBusqueda.map[banco|banco as Banco]

		Assert.assertTrue(bancosEncontrados.exists [ banco |
			(banco.sucursal.equals("Avellaneda")) && (banco.nombreGerente.equals("Javier Loeschbor"))
		])
	}

	@Test
	def void buscarBancoLlamadoBancoDeLaPlazaYVerSiEstáSucursalCaballito() {
		val resultadoBusqueda = buscador.buscar("Banco de la Plaza")
		val bancosEncontrados = resultadoBusqueda.map[banco|banco as Banco]

		Assert.assertTrue(bancosEncontrados.exists [ banco |
			(banco.sucursal.equals("Caballito")) && (banco.palabrasClave.contains("transferencias"))
		])
	}

	@Test
	def void buscarBancoLlamadoGaliciaYQueDevuelvaListaVacía() {
		val resultadoBusqueda = buscador.buscar("Galicia")

		Assert.assertTrue(resultadoBusqueda.empty)
	}

}
