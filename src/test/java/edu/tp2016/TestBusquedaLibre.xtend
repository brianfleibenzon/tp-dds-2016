package edu.tp2016

import com.google.common.collect.Lists
import edu.tp2016.mod.Comuna
import edu.tp2016.mod.DiaDeAtencion
import edu.tp2016.mod.Rubro
import edu.tp2016.mod.Servicio
import edu.tp2016.pois.Banco
import edu.tp2016.pois.CGP
import edu.tp2016.pois.Comercio
import edu.tp2016.pois.ParadaDeColectivo
import java.util.Arrays
import java.util.List
import org.joda.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon
import edu.tp2016.builder.BancoBuilder
import edu.tp2016.builder.ParadaBuilder
import edu.tp2016.builder.ComercioBuilder
import edu.tp2016.builder.CGPBuilder
import edu.tp2016.usuarios.Terminal

class TestBusquedaLibre {

	Terminal unaTerminal
	ParadaDeColectivo utn7parada
	ParadaDeColectivo miserere7parada
	ParadaDeColectivo utn114parada
	CGP CGPComuna1
	CGP CGPComuna2
	Rubro rubroFarmacia
	Rubro rubroLibreria
	Comercio comercioFarmacity
	Comercio comercioLoDeJuan
	Banco bancoGalicia
	Servicio cultura
	Servicio deportes
	Servicio asesoramientoLegal
	Servicio salud
	Servicio turismo
	Point ubicacionX
	DiaDeAtencion unDiaX
	List<DiaDeAtencion> rangoX
	Comuna comunaX
	LocalDateTime fechaX

	@Before
	def void setUp() {

		ubicacionX = new Point(-1, 1)
		rangoX = Arrays.asList(Lists.newArrayList(unDiaX))
		fechaX = new LocalDateTime()
		comunaX = new Comuna => [
			poligono = new Polygon()
			poligono.add(new Point(-1, 1))
			poligono.add(new Point(-2, 2))
			poligono.add(new Point(-3, 3))
			poligono.add(new Point(-4, 4))
		]

			utn7parada = new ParadaBuilder().nombre("7").
		ubicacion(ubicacionX).
		claves( Arrays.asList("utn", "campus")).build

		miserere7parada = new ParadaBuilder().nombre("7").
		ubicacion(ubicacionX).
		 claves(Arrays.asList("utn", "plaza miserere", "once")).build

		utn114parada = new ParadaBuilder().nombre("114").
		ubicacion(ubicacionX).
		claves(Arrays.asList("utn", "campus")).build

		bancoGalicia = new BancoBuilder().nombre("Banco Galicia Callao").
		ubicacion(ubicacionX).
		claves(Arrays.asList("cajero", "sucursal galicia", "banco")).
		sucursal("Almagro").
		nombreGerente("Juan Perez").
		setearHorarios.
		build

		cultura = new Servicio("cultura", rangoX)

		deportes = new Servicio("deportes", rangoX)

		asesoramientoLegal = new Servicio("asesoramiento legal", rangoX)

		turismo = new Servicio("turismo", rangoX)

		salud = new Servicio("salud", rangoX)

		CGPComuna1 = new CGPBuilder().nombre("CGP Comuna 1").
		ubicacion(ubicacionX).
		claves(Arrays.asList("CGP", "centro de atencion", "servicios sociales", "comuna 1")).
		comuna(comunaX).
		servicio(Arrays.asList(asesoramientoLegal, cultura, deportes)).
		zonasIncluidas("").
		nombreDirector("").
		telefono( "").
		build

		CGPComuna2 = new CGPBuilder().nombre("CGP Comuna 2").
		ubicacion(ubicacionX).
		claves(Arrays.asList("CGP", "centro de atencion", "servicios sociales", "comuna 2")).
		comuna(comunaX).
		servicio(Arrays.asList(turismo, cultura, salud)).
		zonasIncluidas("").
	    nombreDirector("").
	    telefono("").
	    build

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
		unaTerminal.repo.agregarVariosPois(Lists.newArrayList(utn7parada, miserere7parada, utn114parada, CGPComuna1, CGPComuna2, comercioFarmacity,
				comercioLoDeJuan, bancoGalicia))
	}

	@Test
	def void buscarCadenaVaciaQueDevuelveListaVacia() {
		Assert.assertEquals(Arrays.asList(), unaTerminal.buscar(""))
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
	def void buscarBancoPorNombre() {
		Assert.assertEquals(unaTerminal.buscar("banco galicia callao"), Arrays.asList(bancoGalicia))
	}

	@Test
	def void buscarBancoConUnaPalabraClave() {
		Assert.assertEquals(unaTerminal.buscar("sucursal galicia"), Arrays.asList(bancoGalicia))
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
	def void buscarCGPEscribiendoServicioEntero() {
		Assert.assertEquals(unaTerminal.buscar("cultura"), Arrays.asList(CGPComuna1, CGPComuna2))
	}

	@Test
	def void buscarCGPEscribiendoServicioParcial() {
		Assert.assertEquals(unaTerminal.buscar("asesoramiento"), Arrays.asList(CGPComuna1))
	}

	@Test
	def void buscarCGPEscrbiendoPalabraClave() {
		Assert.assertEquals(unaTerminal.buscar("comuna 2"), Arrays.asList(CGPComuna2))
	}

	@Test
	def void buscarYQueNoHayaCoincidencias() {
		Assert.assertEquals(unaTerminal.buscar("palabraInexistente"), Arrays.asList())
	}

}
