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
			palabrasClave.addAll("utn", "campus")
		]
		miserere7parada = new ParadaDeColectivo() => [
			nombre = "7"
			palabrasClave.addAll("utn", "campus")
		]		
		utn114parada = new ParadaDeColectivo() => [
			nombre = "114"
			palabrasClave.addAll("utn", "campus")
		]
		bancoGalicia = new Banco() => [
			nombre = "Banco Galicia Callao"
			palabrasClave.addAll("cajero", "sucursal galicia")
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
			nombre="CGP Comuna 1"
			servicios.addAll(asesoramientoLegal, cultura, deportes)
			palabrasClave.addAll("CGP", "centro de atencion", "servicios sociales", "vecinos")
		]
		CGPComuna2 = new CGP() => [
			nombre="CGP Comuna 2"
			servicios.addAll(turismo, cultura, salud)	
			palabrasClave.addAll("CGP", "centro de atencion", "servicios sociales", "vecinos")
		]		
		rubroFarmacia = new Rubro => [
			nombre= "Farmacia"
		]	
		rubroLibreria = new Rubro => [
			nombre="Libreria"
		]
		comercioFarmacity = new Comercio() => [
			nombre="Farmacity"
			rubro = rubroFarmacia
			palabrasClave.addAll("medicamentos", "salud")
		]
		comercioLoDeJuan = new Comercio() => [
			nombre="Libreria Juan"
			rubro = rubroLibreria
			palabrasClave.addAll("fotocopias", "utiles", "libros")
		]
		unDispositivo = new Dispositivo() => [
			pois.addAll(utn7parada, miserere7parada, utn114parada, CGPComuna1, CGPComuna2, comercioFarmacity,comercioLoDeJuan, bancoGalicia)	
	]
	}
	
	@Test
	def void buscarParadaDeColectivo7OPCION1(){
		Assert.assertTrue((unDispositivo.buscar("7")).containsAll(Arrays.asList(utn7parada, miserere7parada)))
	}// Usando containsAll
	
	@Test
	def void buscarParadaDeColectivo7OPCION2(){
		Assert.assertTrue((unDispositivo.buscar("7")).equals(Arrays.asList(utn7parada, miserere7parada)))
	}// Usando equals
	
	@Test
	def void buscarParadaDeColectivo7OPCION3(){
		Assert.assertEquals((unDispositivo.buscar("7")), Arrays.asList(utn7parada, miserere7parada))
	}// Directamente usando assertEquals
	
	}
	
	/* OBS.: NO HAY UNA FORMA CORTA (DIRECTA) DE CREAR LISTAS DE TIPO 'List',
	 * HAY QUE MANDARLE LOS MENSAJES newArrayList O asList A LA CLASE 'Arrays', O BIEN, A LA CLASE 'Lists' */
	
	/*
	 
	@Test
	def void buscarParada114() {
		"114"
	}
	
	@Test
	def void buscarBancoPorNombre() {
		"Banco Galicia Callao"
	}
	
	@Test
	def void buscarPrimerPOIConAlgunaPalabraClave() {
		"sucursal galicia"
	}
	
	@Test
	def void buscarSegundoPOIConAlgunaPalabraClave() {
		"campus"
	}
	
	@Test
	def void buscarComercioPorRubro() {
		"Libreria"
	}
	@Test
	def void buscarComercioPorNombre() {
		"Farmacity"
	}
	
	@Test
	def void buscarPorServicioEntero() {
		"Salud"
	}
	
	@Test
	def void buscarPorServicioParcial() {
		"Asesoramiento"
*/