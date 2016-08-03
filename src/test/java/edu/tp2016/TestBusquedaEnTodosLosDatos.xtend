package edu.tp2016

import edu.tp2016.serviciosExternos.banco.AdapterBanco
import edu.tp2016.serviciosExternos.banco.StubInterfazBanco
import edu.tp2016.serviciosExternos.cgp.AdapterCGP
import edu.tp2016.serviciosExternos.cgp.StubInterfazCGP
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
import edu.tp2016.builder.ParadaBuilder
import edu.tp2016.builder.ComercioBuilder
import edu.tp2016.usuarios.Terminal

class TestBusquedaEnTodosLosDatos {
	Terminal unaTerminal
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

		utn7parada = new ParadaBuilder().nombre("7").
		ubicacion(ubicacionX).
		claves( Arrays.asList("utn", "campus")).build

		miserere7parada = new ParadaBuilder().nombre("7").
		ubicacion(ubicacionX).
		 claves(Arrays.asList("utn", "plaza miserere", "once")).build

		utn114parada = new ParadaBuilder().nombre("114").
		ubicacion(ubicacionX).
		claves(Arrays.asList("utn", "campus")).build

		rubroFarmacia = new Rubro("Farmacia", 1)

		rubroLibreria = new Rubro("Libreria", 2)
		
	
	    comercioFarmacity = new ComercioBuilder().nombre("Farmacity").
		ubicacion(ubicacionX).
		claves(Arrays.asList("medicamentos", "salud")).
		rubro(rubroFarmacia).
		rango(rangoX).build

		comercioLoDeJuan = new ComercioBuilder().nombre("Libreria Juan").
		ubicacion(ubicacionX).
		claves(Arrays.asList("fotocopias", "utiles", "libros")).
		rubro(rubroLibreria).
		rango(rangoX).build
	
		unaTerminal = new Terminal(ubicacionX, "terminalX", fechaX)

		unaTerminal.repo.create(utn7parada)
		unaTerminal.repo.create(utn114parada)
		unaTerminal.repo.create(miserere7parada)
		unaTerminal.repo.create(comercioFarmacity)
		unaTerminal.repo.create(comercioLoDeJuan)
		
		unaTerminal.interfacesExternas.add(new AdapterBanco(new StubInterfazBanco))
		unaTerminal.interfacesExternas.add(new AdapterCGP(new StubInterfazCGP))

	}

	@Test
	def void buscarConUnStringVacíoYQueDevuelvaListaVacía() {
		val resultadoBusqueda = unaTerminal.buscar("")
		
		Assert.assertTrue(resultadoBusqueda.empty)
	}

	@Test
	def void buscarParadaDeColectivo7() {
		Assert.assertEquals(unaTerminal.buscar("7"), Arrays.asList(utn7parada, miserere7parada))
	}

	@Test
	def void buscarParadaDeColectivo114() {
		Assert.assertEquals(unaTerminal.buscar("114"), Arrays.asList(utn114parada))
	}
	
	@Test
	def void buscarParadaDeColectivoConUnaPalabraClave() {
		Assert.assertEquals(unaTerminal.buscar("campus"), Arrays.asList(utn7parada, utn114parada))
	}

	@Test
	def void buscarComercioPorRubro() {
		Assert.assertEquals(unaTerminal.buscar("libreria"), Arrays.asList(comercioLoDeJuan))
	}

	@Test
	def void buscarComercioPorNombre() {
		Assert.assertEquals(unaTerminal.buscar("farmacity"), Arrays.asList(comercioFarmacity))
	}

	@Test
	def void buscarComercioConUnaPalabraClave() {
		Assert.assertEquals(unaTerminal.buscar("farmacity"), Arrays.asList(comercioFarmacity))
	}

	@Test
	def void buscarCGPConRentas() {
		val resultado = unaTerminal.buscar("Rentas")
		val unCGP = resultado.get(0) as CGP
		Assert.assertEquals(2, unCGP.comuna.numero)
	}

	@Test
	def void buscarCGPConAtencionCiudadana() {
		val resultado = unaTerminal.buscar("Atencion ciudadana")
		val unCGP = resultado.get(0) as CGP
		Assert.assertEquals(3, unCGP.comuna.numero)
	}

	@Test
	def void buscarCGPConVeterinaria() {
		val resultado = unaTerminal.buscar("Veterinaria")
		Assert.assertEquals(0, resultado.size)
	}

	@Test
	def void buscarBancoLlamadoSantanderRío() {
		val bancoEncontrado = (unaTerminal.buscar("Santander Rio")).get(0) as Banco

		Assert.assertEquals("María Luna", bancoEncontrado.nombreGerente)
		Assert.assertTrue(bancoEncontrado.palabrasClave.contains("seguros"))
	}

	@Test
	def void buscarBancoLlamadoBancoDeLaPlazaYVerSiEstáSucursalAvellaneda() {
		val resultadoBusqueda = unaTerminal.buscar("Banco de la Plaza")
		val bancosEncontrados = resultadoBusqueda.map [ banco | banco as Banco ]
		
		Assert.assertTrue(bancosEncontrados.exists [ banco |
			(banco.sucursal.equals("Avellaneda")) && (banco.nombreGerente.equals("Javier Loeschbor")) ] )
	}

	@Test
	def void buscarBancoLlamadoBancoDeLaPlazaYVerSiEstáSucursalCaballito() {
		val resultadoBusqueda = unaTerminal.buscar("Banco de la Plaza")
		val bancosEncontrados = resultadoBusqueda.map[ banco | banco as Banco ]
		
		Assert.assertTrue(bancosEncontrados.exists[ banco |
			(banco.sucursal.equals("Caballito")) && (banco.palabrasClave.contains("transferencias")) ] )
	}

	@Test
	def void buscarBancoLlamadoGaliciaYQueDevuelvaListaVacía() {
		val resultadoBusqueda = unaTerminal.buscar("Galicia")
		
		Assert.assertTrue(resultadoBusqueda.empty)
	}
	
}
