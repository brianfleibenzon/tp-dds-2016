package edu.tp2016.applicationModel

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.buscador.Buscador
import edu.tp2016.pois.POI
import java.util.List
import edu.tp2016.usuarios.Terminal
import com.google.common.collect.Lists
import org.uqbar.geodds.Point
import edu.tp2016.builder.ParadaBuilder
import java.util.Arrays
import edu.tp2016.builder.ComercioBuilder
import edu.tp2016.mod.Rubro
import edu.tp2016.mod.DiaDeAtencion
import java.util.ArrayList
import edu.tp2016.mod.Servicio
import edu.tp2016.builder.CGPBuilder
import org.uqbar.geodds.Polygon
import edu.tp2016.mod.Comuna

@Observable
@Accessors

class BuscadorApplication {
	Buscador buscador = new Buscador =>[
		usuarioActual = new Terminal("terminal")
		repo.agregarVariosPois(crearJuegoDeDatos())
	]
	List<POI> resultados = new ArrayList<POI>
	POI poiSeleccionado
	String busqueda = ""
	
	def crearJuegoDeDatos(){
		val ubicacionX = new Point(-1, 1)
		val rangoX = new ArrayList<DiaDeAtencion>

		val utn7parada = new ParadaBuilder().nombre("7").
		ubicacion(ubicacionX).
		claves( Arrays.asList("utn", "campus")).build

		val miserere7parada = new ParadaBuilder().nombre("7").
		ubicacion(ubicacionX).
		claves(Arrays.asList("utn", "plaza miserere", "once")).build

		val utn114parada = new ParadaBuilder().nombre("114").
		ubicacion(ubicacionX).
		claves(Arrays.asList("utn", "campus")).build

		val rubroFarmacia = new Rubro("Farmacia", 1)

		val rubroLibreria = new Rubro("Libreria", 2)
	
	    val comercioFarmacity = new ComercioBuilder().nombre("Farmacity").
		ubicacion(ubicacionX).
		claves(Arrays.asList("medicamentos", "salud")).
		rubro(rubroFarmacia).
		rango(rangoX).build

		val comercioLoDeJuan = new ComercioBuilder().nombre("Libreria Juan").
		ubicacion(ubicacionX).
		claves(Arrays.asList("fotocopias", "utiles", "libros")).
		rubro(rubroLibreria).
		rango(rangoX).build
		
		val cultura = new Servicio("cultura", rangoX)

		val deportes = new Servicio("deportes", rangoX)

        val asesoramientoLegal = new Servicio("asesoramiento legal", rangoX)
	 
	    val comunaX = new Comuna => [
			poligono = new Polygon()
			poligono.add(new Point(-1, 1))
			poligono.add(new Point(-2, 2))
			poligono.add(new Point(-3, 3))
			poligono.add(new Point(-4, 4))
		]
	
	    val CGPComuna1 = new CGPBuilder().nombre("CGP Comuna 1").ubicacion(ubicacionX).claves(
			Arrays.asList("CGP", "centro de atencion", "servicios sociales", "comuna 1")).comuna(comunaX).servicio(
			Arrays.asList(asesoramientoLegal, cultura, deportes)).zonasIncluidas("").nombreDirector("").telefono("").
			build
	
		val pois = Lists.newArrayList(utn7parada,
								  utn114parada,
								  miserere7parada,
								  comercioFarmacity,
								  comercioLoDeJuan,
								  CGPComuna1)
		pois
	}
	
	def buscar(){
		resultados = buscador.buscar(busqueda)
	}
}