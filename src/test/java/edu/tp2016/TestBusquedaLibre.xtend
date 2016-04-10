package edu.tp2016

import org.junit.Before
import org.junit.Test
import org.junit.Assert

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
			palabrasClave.add("colectivo utn")
		]
		miserere7parada = new ParadaDeColectivo() => [
			nombre = "7"
			palabrasClave.add("colectivo utn")
		]		
		utn114parada = new ParadaDeColectivo() => [
			nombre = "114"
			palabrasClave.add("colectivo utn")
		]
		bancoGalicia = new Banco() => [
			nombre = "Banco Galicia Callao"
			palabrasClave.addAll("cajero callao", "sucursal galicia")
		]
		cultura = new Servicio() => [
			nombre="Cultura"
		]
		deportes = new Servicio() => [
			nombre="Deportes"
		]
		asesoramientoLegal = new Servicio() => [
			nombre="Asesoramiento Legal"
		]
		turismo = new Servicio() => [
			nombre="Turismo"
		]
		salud = new Servicio() => [
			nombre="Salud"
		]
		CGPComuna1 = new CGP() => [
			servicios.addAll(asesoramientoLegal, cultura, deportes)
		]
		CGPComuna2 = new CGP() => [
			servicios.addAll(turismo, cultura, salud)	
		]		
		rubroFarmacia = new Rubro => [
			nombre= "Farmacia"
		]	
		rubroLibreria = new Rubro => [
			nombre="Libreria"
		]
		comercioFarmacity = new Comercio() => [
			rubro = rubroFarmacia
		]
		comercioLoDeJuan = new Comercio() => [
			rubro = rubroLibreria
		]
		unDispositivo = new Dispositivo() => [
			pois.addAll(utn7parada, miserere7parada, utn114parada, CGPComuna1, CGPComuna2, comercioFarmacity,comercioLoDeJuan, bancoGalicia)
	]
	}
	
	/* @Test
	def void buscarParada7() {
		Assert.assertEquals(, unDispositivo.buscar("7"))
	}
	
	@Test
	def void buscarParada114() {
		Assert.assertEquals(, unDispositivo.buscar("114"))
	}
	
	@Test
	def void buscarBancoPorNombre() {
		Assert.assertEquals(, unDispositivo.buscar("Banco Galicia Callao"))
	}
	
	@Test
	def void buscarPrimerPOIConAlgunaPalabraClave() {
		Assert.assertEquals(, unDispositivo.buscar("sucursal galicia"))
	}
	
	@Test
	def void buscarSegundoPOIConAlgunaPalabraClave() {
		Assert.assertEquals(, unDispositivo.buscar("colectivo utn"))
	}
	
	@Test
	def void buscarComercioPorRubro() {
		Assert.assertEquals(, unDispositivo.buscar("Libreria"))
	}
	@Test
	def void buscarComercioPorNombre() {
		Assert.assertEquals(, unDispositivo.buscar("Farmacity"))
	}
	
	@Test
	def void buscarPorServicioEntero() {
		Assert.assertEquals(, unDispositivo.buscar("Salud"))
	}
	
	@Test
	def void buscarPorServicioParcial() {
		Assert.assertEquals(, unDispositivo.buscar("Asesoramiento"))
*/
}