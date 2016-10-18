package edu.tp2016

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
import edu.tp2016.builder.ParadaBuilder
import edu.tp2016.builder.BancoBuilder
import edu.tp2016.builder.CGPBuilder
import edu.tp2016.builder.ComercioBuilder
import com.google.common.collect.Lists
import java.util.ArrayList
import edu.tp2016.pois.POI
import edu.tp2016.applicationModel.Buscador
import edu.tp2016.mod.Punto
import edu.tp2016.repositorio.RepoPois
import org.junit.After

class TestCercania {

	Buscador buscador
	ParadaDeColectivo paradaCerca
	ParadaDeColectivo paradaLejos
	Banco bancoCerca
	Banco bancoLejos
	CGP CGPCerca
	CGP CGPLejos
	Comuna comunaInterior
	Comuna comunaExterior
	Rubro rubroTest
	Comercio comercioCerca
	Comercio comercioLejos
	DiaDeAtencion unDiaX
	List<DiaDeAtencion> rangoX
	LocalDateTime fechaX
	List<String> clavesX
	List<Servicio> serviciosX
	ArrayList<POI> pois
	Banco poiReferencia

	@Before
	def void setUp() {

		rangoX = Arrays.asList()
		fechaX = new LocalDateTime()
		clavesX = Arrays.asList()
		poiReferencia = new Banco() => [
			ubicacion = new Punto(-34.598574, -58.420280)
		]

		serviciosX = Arrays.asList()

		paradaCerca = new ParadaBuilder().nombre("114").ubicacion(new Punto(-34.597768, -58.419860)).claves(clavesX).
			build

		paradaLejos = new ParadaBuilder().nombre("107").ubicacion(new Punto(-34.597859, -58.423351)).claves(clavesX).
			build

		bancoCerca = new BancoBuilder().nombre("Santander").ubicacion(new Punto(-34.597768, -58.419860)).claves(
			clavesX).sucursal("Caballito").nombreGerente("Juan Perez").setearHorarios.build

		bancoLejos = new BancoBuilder().nombre("Galicia").ubicacion(new Punto(-34.594150, -58.416313)).claves(clavesX).
			sucursal("Belgrano").nombreGerente("María García").setearHorarios.build

		comunaInterior = new Comuna => [
			poligono.add(new Punto(-34.597735, -58.421806))
			poligono.add(new Punto(-34.597771, -58.417300))
			poligono.add(new Punto(-34.600703, -58.420583))
			poligono.add(new Punto(-34.601497, -58.416227))
		]
		
		comunaExterior = new Comuna => [
			poligono.add(new Punto(-34.597735, -58.421806))
			poligono.add(new Punto(-34.597771, -58.417300))
			poligono.add(new Punto(-34.594238, -58.419617))
			poligono.add(new Punto(-34.594167, -58.416334))
		]

		CGPCerca = new CGPBuilder().nombre("CGP Caballito").ubicacion(new Punto(-34.597768, -58.419860)).claves(
			clavesX).comuna(comunaInterior).servicio(serviciosX).zonasIncluidas("").nombreDirector("").telefono("").
			build

		CGPLejos = new CGPBuilder().nombre("CGP Almagro").ubicacion(new Punto(-34.594150, -58.416313)).claves(clavesX).
			comuna(comunaExterior).servicio(serviciosX).zonasIncluidas("").nombreDirector("").telefono("").build

		rubroTest = new Rubro("indumentaria", 2)

		comercioCerca = new ComercioBuilder().nombre("test").ubicacion(new Punto(-34.597768, -58.419860)).claves(
			clavesX).rubro(rubroTest).rango(rangoX).build

		comercioLejos = new ComercioBuilder().nombre("test").ubicacion(new Punto(-34.597824, -58.423415)).claves(
			clavesX).rubro(rubroTest).rango(rangoX).build

		pois = Lists.newArrayList(bancoCerca, bancoLejos, CGPCerca, CGPLejos, comercioCerca, comercioLejos, paradaCerca,
			paradaLejos)

		buscador = new Buscador() => [
			repo = RepoPois.instance
			repo.borrarDatos();	
			repo.agregarVariosPois(pois)
		]
	}
	
	@After
	def void finalizar(){
		RepoPois.instance.borrarDatos()
	}

	@Test
	def void paradaEstaCerca() {
		Assert.assertTrue(buscador.consultarCercania(paradaCerca, poiReferencia))
	}

	@Test
	def void paradaEstaLejos() {
		Assert.assertFalse(buscador.consultarCercania(paradaLejos, poiReferencia))
	}

	@Test
	def void bancoEstaCerca() {
		Assert.assertTrue(buscador.consultarCercania(bancoCerca, poiReferencia))
	}

	@Test
	def void bancoEstaLejos() {
		Assert.assertFalse(buscador.consultarCercania(bancoLejos, poiReferencia))
	}

	@Test
	def void CGPEstaCerca() {
		Assert.assertTrue(buscador.consultarCercania(CGPCerca, poiReferencia))
	}

	@Test
	def void CGPEstaLejos() {
		Assert.assertFalse(buscador.consultarCercania(CGPLejos, poiReferencia))
	}

	@Test
	def void comercioEstaCerca() {
		Assert.assertTrue(buscador.consultarCercania(comercioCerca, poiReferencia))
	}

	@Test
	def void comercioEstaLejos() {
		Assert.assertFalse(buscador.consultarCercania(comercioLejos, poiReferencia))
	}

}
