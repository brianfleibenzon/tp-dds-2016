package edu.tp2016

import com.google.common.collect.Lists
import edu.tp2016.applicationModel.Buscador
import edu.tp2016.builder.BancoBuilder
import edu.tp2016.builder.CGPBuilder
import edu.tp2016.builder.ComercioBuilder
import edu.tp2016.builder.ParadaBuilder
import edu.tp2016.mod.Comuna
import edu.tp2016.mod.DiaDeAtencion
import edu.tp2016.mod.Punto
import edu.tp2016.mod.Rubro
import edu.tp2016.mod.Servicio
import edu.tp2016.pois.Banco
import edu.tp2016.pois.CGP
import edu.tp2016.pois.Comercio
import edu.tp2016.pois.POI
import edu.tp2016.pois.ParadaDeColectivo
import edu.tp2016.repositorio.RepoPois
import edu.tp2016.usuarios.Terminal
import java.util.Arrays
import java.util.List
import java.util.Set
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestBusquedaLibre {

	Buscador buscador
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
	Servicio cultura2
	Servicio deportes
	Servicio asesoramientoLegal
	Servicio salud
	Servicio turismo
	Punto ubicacionX
	List<DiaDeAtencion> rangoX
	Comuna comunaX

	@Before
	def void setUp() {
		
		rangoX = Lists.newArrayList()
		
		comunaX = new Comuna => [
			poligono.add(new Punto(-1, 1))
			poligono.add(new Punto(-2, 2))
			poligono.add(new Punto(-3, 3))
			poligono.add(new Punto(-4, 4))
		]

		utn7parada = new ParadaBuilder().nombre("7").ubicacion(ubicacionX).claves(Arrays.asList("utn", "campus")).build

		miserere7parada = new ParadaBuilder().nombre("7").ubicacion(ubicacionX).claves(
			Arrays.asList("utn", "plaza miserere", "once")).build

		utn114parada = new ParadaBuilder().nombre("114").ubicacion(ubicacionX).claves(Arrays.asList("utn", "campus")).
			build

		bancoGalicia = new BancoBuilder().nombre("Banco Galicia Callao").ubicacion(ubicacionX).claves(
			Arrays.asList("cajero", "sucursal galicia", "banco")).sucursal("Almagro").nombreGerente("Juan Perez").
			setearHorarios.build

		cultura = new Servicio("cultura", Lists.newArrayList(new DiaDeAtencion()))
		
		cultura2 = new Servicio("cultura", Lists.newArrayList(new DiaDeAtencion()))

		deportes = new Servicio("deportes", Lists.newArrayList(new DiaDeAtencion()))

		asesoramientoLegal = new Servicio("asesoramiento legal", rangoX)

		turismo = new Servicio("turismo", rangoX)

		salud = new Servicio("salud", rangoX)

		CGPComuna1 = new CGPBuilder().nombre("CGP Comuna 1").ubicacion(ubicacionX).claves(
			Arrays.asList("CGP", "centro de atencion", "servicios sociales", "comuna 1")).comuna(comunaX).servicio(
			Arrays.asList(asesoramientoLegal, cultura, deportes)).zonasIncluidas("").nombreDirector("").telefono("").
			build

		CGPComuna2 = new CGPBuilder().nombre("CGP Comuna 2").ubicacion(ubicacionX).claves(
			Arrays.asList("CGP", "centro de atencion", "servicios sociales", "comuna 2")).comuna(comunaX).servicio(
			Arrays.asList(turismo, cultura2, salud)).zonasIncluidas("").nombreDirector("").telefono("").build

		rubroFarmacia = new Rubro("Farmacia", 1)

		rubroLibreria = new Rubro("Libreria", 2)

		comercioFarmacity = new ComercioBuilder().nombre("Farmacity").ubicacion(ubicacionX).claves(
			Arrays.asList("medicamentos", "salud")).rubro(rubroFarmacia).rango(rangoX).build

		comercioLoDeJuan = new ComercioBuilder().nombre("Libreria Juan").ubicacion(ubicacionX).claves(
			Arrays.asList("fotocopias", "utiles", "libros")).rubro(rubroLibreria).rango(rangoX).build

		buscador = new Buscador() =>
			[
				repo = RepoPois.instance
				repo.modificarAEsquemaTest()
				repo.borrarDatos()
				repo.agregarVariosPois(
					Lists.newArrayList(utn7parada, miserere7parada, utn114parada, CGPComuna1, CGPComuna2,
						comercioFarmacity, comercioLoDeJuan, bancoGalicia))
				usuarioActual = new Terminal("terminal")
			]

	}
	
	@After
	def void finalizar(){
		RepoPois.instance.borrarDatos()
	}
	
	def boolean coinciden (Set<POI> resultado, List<POI> esperado){
		resultado.size == esperado.size && esperado.forall[poi | resultado.exists[it.id == poi.id]]
	}

	@Test
	def void buscarParadaDeColectivo7() {
		Assert.assertTrue(coinciden(buscador.buscar("7"), Arrays.asList(utn7parada, miserere7parada)))
	}

	@Test
	def void buscarParadaDeColectivo114() {
		Assert.assertTrue(coinciden(buscador.buscar("114"), Arrays.asList(utn114parada)))
	}

	@Test
	def void buscarBancoPorNombre() {
		Assert.assertTrue(coinciden(buscador.buscar("banco galicia callao"), Arrays.asList(bancoGalicia)))
	}

	@Test
	def void buscarBancoConUnaPalabraClave() {
		Assert.assertTrue(coinciden(buscador.buscar("sucursal galicia"), Arrays.asList(bancoGalicia)))
	}

	@Test
	def void buscarParadaDeColectivoConUnaPalabraClave() {
		Assert.assertTrue(coinciden(buscador.buscar("campus"), Arrays.asList(utn7parada, utn114parada)))
	}

	@Test
	def void buscarComercioPorRubro() {
		Assert.assertTrue(coinciden(buscador.buscar("libreria"), Arrays.asList(comercioLoDeJuan)))
	}

	@Test
	def void buscarComercioPorNombre() {
		Assert.assertTrue(coinciden(buscador.buscar("farmacity"), Arrays.asList(comercioFarmacity)))
	}

	@Test
	def void buscarComercioConUnaPalabraClave() {
		Assert.assertTrue(coinciden(buscador.buscar("farmacity"), Arrays.asList(comercioFarmacity)))
	}

	@Test
	def void buscarCGPEscribiendoServicioEntero() {
		Assert.assertTrue(coinciden(buscador.buscar("cultura"), Arrays.asList(CGPComuna1, CGPComuna2)))
	}

	@Test
	def void buscarCGPEscribiendoServicioParcial() {
		Assert.assertTrue(coinciden(buscador.buscar("asesoramiento"), Arrays.asList(CGPComuna1)))
	}

	@Test
	def void buscarCGPEscrbiendoPalabraClave() {
		Assert.assertTrue(coinciden(buscador.buscar("comuna 2"), Arrays.asList(CGPComuna2)))
	}

	@Test
	def void buscarYQueNoHayaCoincidencias() {
		Assert.assertTrue(coinciden(buscador.buscar("palabraInexistente"), Arrays.asList()))
	}

}
