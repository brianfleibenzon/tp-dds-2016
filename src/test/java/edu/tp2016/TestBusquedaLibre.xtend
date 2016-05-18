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
import edu.tp2016.sistema.Sistema
import java.util.Arrays
import java.util.List
import org.joda.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon
import edu.tp2016.sistema.Terminal
import edu.tp2016.Builder.BuilderParada
import edu.tp2016.Builder.BuilderBanco
import edu.tp2016.Builder.BuilderComercio
import edu.tp2016.Builder.BuilderCGP

class TestBusquedaLibre {

	Sistema unSistema
	
	Rubro rubroFarmacia
	Rubro rubroLibreria
	
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
	Terminal terminal
	/*Builder */
	ParadaDeColectivo utn7parada
	ParadaDeColectivo miserere7parada
	ParadaDeColectivo utn114parada
	Banco bancoGalicia
	Comercio comercioFarmacity
	Comercio comercioLoDeJuan
	CGP CGPComuna1
	CGP CGPComuna2
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

		bancoGalicia = new BuilderBanco().nombre("Banco Galicia Callao")
										 .ubicacion(ubicacionX)
										 .claves(Arrays.asList("cajero", "sucursal galicia", "banco"))
										 .sucursal("Almagro")
										 .nombreDeGerente("Juan Perez")
										 .rangoDeAtencion
										 .build
		
		cultura = new Servicio("cultura", rangoX)

		deportes = new Servicio("deportes", rangoX)

		asesoramientoLegal = new Servicio("asesoramiento legal", rangoX)

		turismo = new Servicio("turismo", rangoX)

		salud = new Servicio("salud", rangoX)

		CGPComuna1 = new BuilderCGP().nombre("CGP Comuna 1")
									 .ubicacion(ubicacionX)
									 .claves(Arrays.asList("CGP", "centro de atencion", "servicios sociales", "comuna 1"))
									 .comuna(comunaX)
									 .servicios(Arrays.asList(asesoramientoLegal, cultura, deportes))
									 .build
		
		CGPComuna2 = new BuilderCGP().nombre("CGP Comuna 2")
									 .ubicacion(ubicacionX)
									 .claves(Arrays.asList("CGP", "centro de atencion", "servicios sociales", "comuna 2"))
									 .comuna(comunaX)
									 .servicios(Arrays.asList(turismo, cultura, salud))
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
		unSistema = new Sistema(
			Arrays.asList(utn7parada, miserere7parada, utn114parada, CGPComuna1, CGPComuna2, comercioFarmacity,
				comercioLoDeJuan, bancoGalicia), fechaX)
				
		terminal = new Terminal("terminalAbasto", new Point(-1, -1), unSistema)
			

	}

	@Test
	def void buscarCadenaVaciaQueDevuelveListaVacia() {
		Assert.assertEquals(Arrays.asList(), terminal.buscar(""))
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
	def void buscarBancoPorNombre() {
		Assert.assertEquals(terminal.buscar("banco galicia callao"), Arrays.asList(bancoGalicia))
	}

	@Test
	def void buscarBancoConUnaPalabraClave() {
		Assert.assertEquals(terminal.buscar("sucursal galicia"), Arrays.asList(bancoGalicia))
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
	def void buscarCGPEscribiendoServicioEntero() {
		Assert.assertEquals(terminal.buscar("cultura"), Arrays.asList(CGPComuna1, CGPComuna2))
	}

	@Test
	def void buscarCGPEscribiendoServicioParcial() {
		Assert.assertEquals(terminal.buscar("asesoramiento"), Arrays.asList(CGPComuna1))
	}

	@Test
	def void buscarCGPEscrbiendoPalabraClave() {
		Assert.assertEquals(terminal.buscar("comuna 2"), Arrays.asList(CGPComuna2))
	}

	@Test
	def void buscarYQueNoHayaCoincidencias() {
		Assert.assertEquals(terminal.buscar("palabraInexistente"), Arrays.asList())
	}

}
