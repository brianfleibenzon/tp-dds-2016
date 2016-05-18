package edu.tp2016

import edu.tp2016.Builder.BuilderParada
import edu.tp2016.mod.Comuna
import edu.tp2016.mod.DiaDeAtencion
import edu.tp2016.mod.Rubro
import edu.tp2016.mod.Servicio
import edu.tp2016.pois.Banco
import edu.tp2016.pois.CGP
import edu.tp2016.pois.Comercio
import edu.tp2016.pois.POI
import edu.tp2016.pois.ParadaDeColectivo
import edu.tp2016.sistema.Sistema
import edu.tp2016.sistema.Terminal
import java.util.Arrays
import java.util.List
import org.joda.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon
import edu.tp2016.Builder.BuilderBanco
import edu.tp2016.Builder.BuilderComercio
import edu.tp2016.Builder.BuilderCGP

class TestCercania {

	Sistema unSistema
	Comuna comunaInterior
	Comuna comunaExterior
	Rubro rubroTest
	
	DiaDeAtencion unDiaX
	List<DiaDeAtencion> rangoX
	LocalDateTime fechaX
	List<String> clavesX
	List<POI> poisX
	List<Servicio> serviciosX
	Point ubicacion
	Terminal terminal
	
	/*BUILDER */
	 ParadaDeColectivo paradaCerca
	 ParadaDeColectivo paradaLejos
	 Banco bancoCerca
	 Banco bancoLejos
	 Comercio comercioCerca
	 Comercio comercioLejos
	 CGP CGPCerca
	 CGP CGPLejos
	
	@Before
	def void setUp() {
		
		rangoX = Arrays.asList(unDiaX)
		fechaX = new LocalDateTime()
		clavesX = Arrays.asList("algunas", "palabras", "clave")

		serviciosX = Arrays.asList(new Servicio("x", rangoX))

		paradaCerca =new BuilderParada().nombre("114")
						.ubicacion(new Point(-34.597768, -58.419860))
						.claves(clavesX)
						.build

		paradaLejos = new BuilderParada().nombre("107")
						 .ubicacion(new Point(-34.597859, -58.423351))
						 .claves(clavesX)
						 .build

		bancoCerca = new BuilderBanco().nombre("Santander")
									   .ubicacion(new Point(-34.597768, -58.419860))
									   .claves(clavesX)
									   .sucursal("Caballito")
									   .nombreDeGerente("Juan Perez")
									   .rangoDeAtencion
									   .build
									   
		bancoLejos = new BuilderBanco().nombre("Galicia")
									   .ubicacion(new Point(-34.594150, -58.416313))
									   .claves(clavesX)
									   .sucursal("Belgrano")
									   .nombreDeGerente("María García")
									   .rangoDeAtencion
									   .build
									   
		comunaInterior = new Comuna => [
			poligono = new Polygon()
			poligono.add(new Point(-34.597735, -58.421806))
			poligono.add(new Point(-34.597771, -58.417300))
			poligono.add(new Point(-34.600703, -58.420583))
			poligono.add(new Point(-34.601497, -58.416227))
		]
		comunaExterior = new Comuna => [
			poligono = new Polygon()
			poligono.add(new Point(-34.597735, -58.421806))
			poligono.add(new Point(-34.597771, -58.417300))
			poligono.add(new Point(-34.594238, -58.419617))
			poligono.add(new Point(-34.594167, -58.416334))
		]

		CGPCerca = new BuilderCGP().nombre("CGP Caballito")
								   .ubicacion(new Point(-34.597768, -58.419860))
								   .claves(clavesX)
								   .comuna(comunaInterior)
								   .servicios(serviciosX)
								   .build						   			
				CGPLejos = new BuilderCGP().nombre("CGP Almagro")
										   .ubicacion(new Point(-34.594150, -58.416313))
										   .claves(clavesX)
										   .comuna(comunaExterior)
										   .servicios(serviciosX)
										   .build
				

		rubroTest = new Rubro("indumentaria", 2)

		comercioCerca = new BuilderComercio().nombre("test")
											 .ubicacion(new Point(-34.597768, -58.419860))
											 .claves(clavesX)
											 .rubro(rubroTest)
											 .rango(rangoX)
											 .build
		

		comercioLejos = new BuilderComercio().nombre("test")
											 .ubicacion(new Point(-34.597824, -58.423415))
											 .claves(clavesX)
											 .rubro(rubroTest)
											 .rango(rangoX)
											 .build
	
		poisX = Arrays.asList(bancoCerca, bancoLejos, CGPCerca, CGPLejos, comercioCerca, comercioLejos,paradaCerca,
			paradaLejos)

		unSistema = new Sistema(poisX, fechaX)
		
		ubicacion = new Point(-34.598574, -58.420280)
		
		terminal = new Terminal("terminalAbasto", ubicacion, unSistema)
		

	}

	@Test
	def void paradaEstaCerca() {
		Assert.assertTrue(terminal.consultarCercania(paradaCerca))
	}

	@Test
	def void paradaEstaLejos() {
		Assert.assertFalse(terminal.consultarCercania(paradaLejos))
	}

	@Test
	def void bancoEstaCerca() {
		Assert.assertTrue(terminal.consultarCercania(bancoCerca))
	}

	@Test
	def void bancoEstaLejos() {
		Assert.assertFalse(terminal.consultarCercania(bancoLejos))
	}

	@Test
	def void CGPEstaCerca() {
		Assert.assertTrue(terminal.consultarCercania(CGPCerca))
	}

	@Test
	def void CGPEstaLejos() {
		Assert.assertFalse(terminal.consultarCercania(CGPLejos))
	}

	@Test
	def void comercioEstaCerca() {
		Assert.assertTrue(terminal.consultarCercania(comercioCerca))
	}

	@Test
	def void comercioEstaLejos() {
		Assert.assertFalse(terminal.consultarCercania(comercioLejos))
	}

}
