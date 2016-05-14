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
import edu.tp2016.sistema.Sistema

class TestBusquedaLibre {

	Sistema unSistema
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

		rangoX = Arrays.asList(Lists.newArrayList(unDiaX))
		fechaX = new LocalDateTime()
		comunaX = new Comuna => [
			poligono = new Polygon()
			poligono.add(new Point(-1, 1))
			poligono.add(new Point(-2, 2))
			poligono.add(new Point(-3, 3))
			poligono.add(new Point(-4, 4))
		]

		utn7parada = new ParadaDeColectivo("7", ubicacionX, Arrays.asList("utn", "campus"))

		miserere7parada = new ParadaDeColectivo("7", ubicacionX, Arrays.asList("utn", "plaza miserere", "once"))

		utn114parada = new ParadaDeColectivo("114", ubicacionX, Arrays.asList("utn", "campus"))

		bancoGalicia = new Banco("Banco Galicia Callao", ubicacionX,
			Arrays.asList("cajero", "sucursal galicia", "banco"), "Almagro", "Juan Perez")

		cultura = new Servicio("cultura", rangoX)

		deportes = new Servicio("deportes", rangoX)

		asesoramientoLegal = new Servicio("asesoramiento legal", rangoX)

		turismo = new Servicio("turismo", rangoX)

		salud = new Servicio("salud", rangoX)

		CGPComuna1 = new CGP("CGP Comuna 1", ubicacionX,
			Arrays.asList("CGP", "centro de atencion", "servicios sociales", "comuna 1"), comunaX,
			Arrays.asList(asesoramientoLegal, cultura, deportes), "", "", "")

		CGPComuna2 = new CGP("CGP Comuna 2", ubicacionX,
			Arrays.asList("CGP", "centro de atencion", "servicios sociales", "comuna 2"), comunaX,
			Arrays.asList(turismo, cultura, salud), "", "", "")

		rubroFarmacia = new Rubro("Farmacia", 1)

		rubroLibreria = new Rubro("Libreria", 2)

		comercioFarmacity = new Comercio("Farmacity", ubicacionX, Arrays.asList("medicamentos", "salud"), rubroFarmacia,
			rangoX)

		comercioLoDeJuan = new Comercio("Libreria Juan", ubicacionX, Arrays.asList("fotocopias", "utiles", "libros"),
			rubroLibreria, rangoX)

		unSistema = new Sistema(
			Arrays.asList(utn7parada, miserere7parada, utn114parada, CGPComuna1, CGPComuna2, comercioFarmacity,
				comercioLoDeJuan, bancoGalicia), fechaX)

	}

	@Test
	def void buscarCadenaVaciaQueDevuelveListaVacia() {
		Assert.assertEquals(Arrays.asList(), unSistema.buscar(""))
	}

	@Test
	def void buscarParadaDeColectivo7() {
		Assert.assertEquals(unSistema.buscar("7"), Arrays.asList(utn7parada, miserere7parada))
	}

	@Test
	def void buscarParadaDeColectivo114() {
		Assert.assertEquals(unSistema.buscar("114"), Arrays.asList(utn114parada))
	}

	@Test
	def void buscarBancoPorNombre() {
		Assert.assertEquals(unSistema.buscar("banco galicia callao"), Arrays.asList(bancoGalicia))
	}

	@Test
	def void buscarBancoConUnaPalabraClave() {
		Assert.assertEquals(unSistema.buscar("sucursal galicia"), Arrays.asList(bancoGalicia))
	}

	@Test
	def void buscarParadaDeColectivoConUnaPalabraClave() {
		Assert.assertEquals(unSistema.buscar("campus"), Arrays.asList(utn7parada, utn114parada))
	}

	@Test
	def void buscarComercioPorRubro() {
		Assert.assertEquals(unSistema.buscar("libreria"), Arrays.asList(comercioLoDeJuan))
	}

	@Test
	def void buscarComercioPorNombre() {
		Assert.assertEquals(unSistema.buscar("farmacity"), Arrays.asList(comercioFarmacity))
	}

	@Test
	def void buscarComercioConUnaPalabraClave() {
		Assert.assertEquals(unSistema.buscar("farmacity"), Arrays.asList(comercioFarmacity))
	}

	@Test
	def void buscarCGPEscribiendoServicioEntero() {
		Assert.assertEquals(unSistema.buscar("cultura"), Arrays.asList(CGPComuna1, CGPComuna2))
	}

	@Test
	def void buscarCGPEscribiendoServicioParcial() {
		Assert.assertEquals(unSistema.buscar("asesoramiento"), Arrays.asList(CGPComuna1))
	}

	@Test
	def void buscarCGPEscrbiendoPalabraClave() {
		Assert.assertEquals(unSistema.buscar("comuna 2"), Arrays.asList(CGPComuna2))
	}

	@Test
	def void buscarYQueNoHayaCoincidencias() {
		Assert.assertEquals(unSistema.buscar("palabraInexistente"), Arrays.asList())
	}

}
