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
import edu.tp2016.sistema.Sistema
import edu.tp2016.sistema.Terminal
import edu.tp2016.Builder.BuilderParada
import edu.tp2016.Builder.BuilderComercio

class TestBusquedaEnTodosLosDatos {
	Sistema unSistema
	Rubro rubroFarmacia
	Rubro rubroLibreria
	
	LocalDateTime fechaX
	DiaDeAtencion unDiaX
	Point ubicacionX
	List<DiaDeAtencion> rangoX
	Terminal terminal
	
	/*Builder */	
	ParadaDeColectivo utn7parada
	ParadaDeColectivo miserere7parada
	ParadaDeColectivo utn114parada
	Comercio comercioFarmacity
	Comercio comercioLoDeJuan
	@Before
	def void setUp() {
		rangoX = Arrays.asList(Lists.newArrayList(unDiaX))
		fechaX = new LocalDateTime()

		utn7parada = new BuilderParada().nombre("7")
						.ubicacion(ubicacionX)
						.claves(Arrays.asList("utn", "campus"))
						.build

		miserere7parada= new BuilderParada().nombre("7")
							.ubicacion(ubicacionX)
							.claves(Arrays.asList("utn","plaza miserere" , "once"))
							.build
		utn114parada = new BuilderParada().nombre("114")
										  .ubicacion(ubicacionX)
										  .claves(Arrays.asList("utn","campus"))
										  .build
				
		rubroFarmacia = new Rubro("Farmacia", 1)

		rubroLibreria = new Rubro("Libreria", 2)

		comercioFarmacity = new BuilderComercio().nombre("Farmacity")
												.ubicacion(ubicacionX)
												.claves(Arrays.asList("medicamentos", "salud"))
												.rubro(rubroFarmacia)
												.rango(rangoX)
												.build
		comercioLoDeJuan = new BuilderComercio().nombre("Libreria Juan")
												.ubicacion(ubicacionX)
												.claves(Arrays.asList("fotocopias", "utiles", "libros"))
												.rubro(rubroLibreria)
												.rango(rangoX)
												.build
		unSistema = new Sistema(Arrays.asList(), fechaX)

		unSistema.repo.create(utn7parada)
		unSistema.repo.create(utn114parada)
		unSistema.repo.create(miserere7parada)
		unSistema.repo.create(comercioFarmacity)
		unSistema.repo.create(comercioLoDeJuan)
		
		unSistema.interfacesExternas.add(new AdapterBanco(new StubInterfazBanco))
		unSistema.interfacesExternas.add(new AdapterCGP(new StubInterfazCGP))
		
		terminal = new Terminal("terminalAbasto", new Point(-1, -1), unSistema)

	}

	@Test
	def void buscarConUnStringVacíoYQueDevuelvaListaVacía() {
		val resultadoBusqueda = terminal.buscar("")
		
		Assert.assertTrue(resultadoBusqueda.empty)
	}

	@Test
	def void buscarParadaDeColectivo7() {
		Assert.assertEquals(terminal.buscar("7"), Arrays.asList(utn7parada, miserere7parada))
	}

	@Test
	def void buscarParadaDeColectivo114() {
		Assert.assertEquals(terminal.buscar("114"), Arrays.asList(utn114parada))
	}
	
	@Test
	def void buscarParadaDeColectivoConUnaPalabraClave() {
		Assert.assertEquals(terminal.buscar("campus"), Arrays.asList(utn7parada, utn114parada))
	}

	@Test
	def void buscarComercioPorRubro() {
		Assert.assertEquals(terminal.buscar("libreria"), Arrays.asList(comercioLoDeJuan))
	}

	@Test
	def void buscarComercioPorNombre() {
		Assert.assertEquals(terminal.buscar("farmacity"), Arrays.asList(comercioFarmacity))
	}

	@Test
	def void buscarComercioConUnaPalabraClave() {
		Assert.assertEquals(terminal.buscar("farmacity"), Arrays.asList(comercioFarmacity))
	}

	@Test
	def void buscarCGPConRentas() {
		val resultado = terminal.buscar("Rentas")
		val unCGP = resultado.get(0) as CGP
		Assert.assertEquals(2, unCGP.comuna.numero)
	}

	@Test
	def void buscarCGPConAtencionCiudadana() {
		val resultado = terminal.buscar("Atencion ciudadana")
		val unCGP = resultado.get(0) as CGP
		Assert.assertEquals(3, unCGP.comuna.numero)
	}

	@Test
	def void buscarCGPConVeterinaria() {
		val resultado = terminal.buscar("Veterinaria")
		Assert.assertEquals(0, resultado.size)
	}

	@Test
	def void buscarBancoLlamadoSantanderRío() {
		val bancoEncontrado = (terminal.buscar("Santander Rio")).get(0) as Banco

		Assert.assertEquals("María Luna", bancoEncontrado.nombreGerente)
		Assert.assertTrue(bancoEncontrado.palabrasClave.contains("seguros"))
	}

	@Test
	def void buscarBancoLlamadoBancoDeLaPlazaYVerSiEstáSucursalAvellaneda() {
		val resultadoBusqueda = terminal.buscar("Banco de la Plaza")
		val bancosEncontrados = resultadoBusqueda.map[ banco | banco as Banco ]
		
		Assert.assertTrue(bancosEncontrados.exists[ banco |
			(banco.sucursal == "Avellaneda") && (banco.nombreGerente == "Javier Loeschbor") ] )
	}

	@Test
	def void buscarBancoLlamadoBancoDeLaPlazaYVerSiEstáSucursalCaballito() {
		val resultadoBusqueda = terminal.buscar("Banco de la Plaza")
		val bancosEncontrados = resultadoBusqueda.map[ banco | banco as Banco ]
		
		Assert.assertTrue(bancosEncontrados.exists[ banco |
			(banco.sucursal == "Caballito") && (banco.palabrasClave.contains("transferencias")) ] )
	}

	@Test
	def void buscarBancoLlamadoGaliciaYQueDevuelvaListaVacía() {
		val resultadoBusqueda = terminal.buscar("Galicia")
		
		Assert.assertTrue(resultadoBusqueda.empty)
	}
	
}
