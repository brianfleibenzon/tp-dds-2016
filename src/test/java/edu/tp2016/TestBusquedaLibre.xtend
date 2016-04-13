package edu.tp2016

import org.junit.Before
import org.junit.Test
import org.junit.Assert
import java.util.Arrays

class TestBusquedaLibre {

	Dispositivo unDispositivo
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

	@Before
	def void setUp() {

		utn7parada = new ParadaDeColectivo() => [
			nombre = "7"
			palabrasClave = Arrays.asList("utn", "campus")
		]
		miserere7parada = new ParadaDeColectivo() => [
			nombre = "7"
			palabrasClave = Arrays.asList("utn", "plaza miserere", "once")
		]
		utn114parada = new ParadaDeColectivo() => [
			nombre = "114"
			palabrasClave = Arrays.asList("utn", "campus")
		]
		bancoGalicia = new Banco() => [
			nombre = "Banco Galicia Callao"
			palabrasClave = Arrays.asList("cajero", "sucursal galicia")
		]
		cultura = new Servicio() => [
			nombre = "cultura"
		]
		deportes = new Servicio() => [
			nombre = "deportes"
		]
		asesoramientoLegal = new Servicio() => [
			nombre = "asesoramiento legal"
		]
		turismo = new Servicio() => [
			nombre = "turismo"
		]
		salud = new Servicio() => [
			nombre = "salud"
		]
		CGPComuna1 = new CGP() => [
			nombre = "CGP Comuna 1"
			servicios = Arrays.asList(asesoramientoLegal, cultura, deportes)
			palabrasClave = Arrays.asList("CGP", "centro de atencion", "servicios sociales", "comuna 1")
		]
		CGPComuna2 = new CGP() => [
			nombre = "CGP Comuna 2"
			servicios = Arrays.asList(turismo, cultura, salud)
			palabrasClave = Arrays.asList("CGP", "centro de atencion", "servicios sociales", "comuna 2")
		]
		rubroFarmacia = new Rubro => [
			nombre = "Farmacia"
		]
		rubroLibreria = new Rubro => [
			nombre = "Libreria"
		]
		comercioFarmacity = new Comercio() => [
			nombre = "Farmacity"
			rubro = rubroFarmacia
			palabrasClave = Arrays.asList("medicamentos", "salud")
		]
		comercioLoDeJuan = new Comercio() => [
			nombre = "Libreria Juan"
			rubro = rubroLibreria
			palabrasClave = Arrays.asList("fotocopias", "utiles", "libros")
		]
		unDispositivo = new Dispositivo() =>
			[
				pois = Arrays.asList(utn7parada, miserere7parada, utn114parada, CGPComuna1, CGPComuna2,
					comercioFarmacity, comercioLoDeJuan, bancoGalicia)
			]
	}

	@Test
	def void buscarParadaDeColectivo7() {
		Assert.assertEquals(unDispositivo.buscar("7"), Arrays.asList(utn7parada, miserere7parada))
	} // Directamente usando assertEquals

	@Test
	def void buscarParadaDeColectivo114() {
		Assert.assertEquals(unDispositivo.buscar("114"), Arrays.asList(utn114parada))
	}

	@Test
	def void buscarBancoPorNombre() {
		Assert.assertEquals(unDispositivo.buscar("banco galicia callao"), Arrays.asList(bancoGalicia))
	}

	@Test
	def void buscarBancoConUnaPalabraClave() {
		Assert.assertEquals(unDispositivo.buscar("sucursal galicia"), Arrays.asList(bancoGalicia))
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
	def void buscarCGPEscribiendoServicioEntero() {
		Assert.assertEquals(unDispositivo.buscar("cultura"), Arrays.asList(CGPComuna1, CGPComuna2))
	}

	@Test
	def void buscarCGPEscribiendoServicioParcial() {
		Assert.assertEquals(unDispositivo.buscar("asesoramiento"), Arrays.asList(CGPComuna1))
	}

	@Test
	def void buscarCGPEscrbiendoPalabraClave() {
		Assert.assertEquals(unDispositivo.buscar("comuna 2"), Arrays.asList(CGPComuna2))
	}

}
