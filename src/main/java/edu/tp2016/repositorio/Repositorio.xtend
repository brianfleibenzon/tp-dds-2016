package edu.tp2016.repositorio

import com.google.common.collect.Lists
import edu.tp2016.builder.BancoBuilder
import edu.tp2016.builder.CGPBuilder
import edu.tp2016.builder.ComercioBuilder
import edu.tp2016.builder.ParadaBuilder
import edu.tp2016.mod.Comuna
import edu.tp2016.mod.DiaDeAtencion
import edu.tp2016.mod.Rubro
import edu.tp2016.mod.Servicio
import edu.tp2016.pois.POI
import edu.tp2016.procesos.ResultadoDeDarDeBajaUnPoi
import java.util.ArrayList
import java.util.Arrays
import java.util.List
import java.util.Random
import org.apache.commons.collections15.Predicate
import org.apache.commons.collections15.functors.AndPredicate
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.CollectionBasedRepo
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon

@Accessors
class Repositorio extends CollectionBasedRepo<POI> {
	private static Repositorio instance = null
	List<ResultadoDeDarDeBajaUnPoi> poisDadosDeBaja = new ArrayList<ResultadoDeDarDeBajaUnPoi>
	Random rand = new Random()

	override createExample() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override def getEntityType() {
		typeof(POI)
	}

	override def Predicate<POI> getCriterio(POI unPoi) {
		var result = this.criterioTodas
		if (unPoi.nombre != null) {
			result = new AndPredicate(result, this.getCriterioPorNombre(unPoi.nombre))
		}
		result
	}
	
	def isEmpty(){
		allInstances.size == 0
	}

	override getCriterioTodas() {
		[POI poi|true] as Predicate<POI>
	}

	def getCriterioPorNombre(String nombre) {
		[POI poi | poi.coincide(nombre)] as Predicate<POI>
	}

	def getCriterioPorPalabraClave(String palabraClave) {
		[POI poi|poi.tienePalabraClave(palabraClave)] as Predicate<POI>
	}
	
	def agregarPoi(POI poi){
		var nuevoId = rand.nextInt(1000) // le asigna un id aleatorio entre 0 y 999
		while(idEnUso(nuevoId)){
			nuevoId = rand.nextInt(1000)
		}
		poi.id = nuevoId
		
		this.create(poi)
	}
	
	def agregarVariosPois(ArrayList<POI> pois){
		pois.forEach [ poi | this.agregarPoi(poi)]
	}
	
	def idEnUso(int id){
		!((objects.filter [ poi | poi.id.equals(id)]).isEmpty)
	}
	
	def eliminarPoi(POI poi){
		this.effectiveDelete(poi)
	}
	
	def actualizarPoi(POI poi){
		if (poi.isNew) {
			agregarPoi(poi) // es un alta
		} else {
			this.update(poi) // es una modificación
		}
	}
	
	def registrarResultadoDeBaja(ResultadoDeDarDeBajaUnPoi resultado){
		poisDadosDeBaja.add(resultado)
	}
	
	static def getInstance() {
		if (instance == null){
			instance = new Repositorio
			instance.agregarVariosPois(crearJuegoDeDatos())
		}
		instance
	}
	
	def doGetPoi(POI unPoi) {
		objects.findFirst [ it.id.equals(unPoi.id)]
	}

	/** Genero una copia del objeto para no actualizar el que referencia el repo **/
	def getPoi(POI unPoi) {
		val result = doGetPoi(unPoi)
		if (result == null) {
			null
		} else {
			result.copy
		} 
	}

	def createIfNotExists(POI poi) {
		val existe = getPoi(poi) != null
		if (!existe) {
			actualizarPoi(poi)
		}
		existe
	}
	
	static def crearJuegoDeDatos(){
		val rangoX = new ArrayList<DiaDeAtencion>
		rangoX.addAll(new DiaDeAtencion(2,10,19,0,0), new DiaDeAtencion(3,10,19,0,0))		
		val ubicacionParadasUTN= new Point(-34.659705, -58.468103)
		
		val utn7parada = new ParadaBuilder().nombre("7_utn").lineaColectivo("7").
		ubicacion(ubicacionParadasUTN).direccion("Mozart 2300").
		claves( Arrays.asList("utn", "campus", "colectivo", "parada")).build
		
		val ubicacionColectivoOnce=new Point(-34.653570, -58.549873)
		val miserere7parada = new ParadaBuilder().nombre("7_once").lineaColectivo("7").
		ubicacion(ubicacionColectivoOnce).direccion("Pueyrredón 1600").
		claves(Arrays.asList("plaza miserere", "once", "colectivo", "parada")).build

		val utn114parada = new ParadaBuilder().nombre("114_utn").lineaColectivo("114").
		ubicacion(ubicacionParadasUTN).direccion("Mozart 2300").
		claves(Arrays.asList("utn", "campus", "colectivo", "parada")).build

		val rubroFarmacia = new Rubro("Farmacia", 1)
		val rubroLibreria = new Rubro("Libreria", 2)
	
		val ubicacionFarmacity=new Point(-34.600319, -58.437463)
	    val comercioFarmacity = new ComercioBuilder().nombre("Farmacity").direccion("Corrientes 5081").
		ubicacion(ubicacionFarmacity).
		claves(Arrays.asList("comercio","medicamentos", "salud", "farmacia")).
		rubro(rubroFarmacia).
		rango(rangoX).build

		val ubicacionLoDeJuan=new Point(-34.600171, -58.420530)
		val comercioLoDeJuan = new ComercioBuilder().nombre("Libreria Juan").direccion("Medrano 850").
		ubicacion(ubicacionLoDeJuan).
		claves(Arrays.asList("comercio","fotocopias", "utiles", "libros")).
		rubro(rubroLibreria).
		rango(rangoX).build
		
		val cultura = new Servicio("Cultura", Lists.newArrayList(new DiaDeAtencion(2,8,16,0,0)))
		val deportes = new Servicio("Deportes", Lists.newArrayList(
			new DiaDeAtencion(2,10,12,0,0), new DiaDeAtencion(4,14,19,30,0),new DiaDeAtencion(6,15,20,30,0)))
        val asesoramientoLegal = new Servicio("Asesoramiento legal", rangoX)
	 
	    val comunaX = new Comuna => [
			poligono = new Polygon()
			poligono.add(new Point(-1, 1))
			poligono.add(new Point(-2, 2))
			poligono.add(new Point(-3, 3))
			poligono.add(new Point(-4, 4))
		]
	
		val ubicacionCGPComuna1 = new Point(-34.608365, -58.370973)
	    val CGPComuna1 = new CGPBuilder().nombre("CGP Comuna 1").
	    	ubicacion(ubicacionCGPComuna1).direccion("Balcarce 52").zonasIncluidas("Puerto Madero-Retiro-San Nicolás").claves(
			Arrays.asList("CGP", "centro de atención", "servicios sociales", "comuna 1")).comuna(comunaX).servicio(
			Arrays.asList(asesoramientoLegal, cultura, deportes)).nombreDirector("").telefono("").build
			
		val ubicacionBancoPatagonia=new Point (-34.657996, -58.471178)
		val BancoPatagonia = new BancoBuilder().nombre("Banco Patagonia").ubicacion(ubicacionBancoPatagonia).direccion("Mozart 2100").claves(
			Arrays.asList("Cobro cheques", "Cajero automático", "Seguros", "Créditos", "Depósitos","Extracciones")).nombreGerente("Armando Lopez").
			sucursal("Lugano").setearHorarios().build
	
		Lists.newArrayList(utn7parada, utn114parada, miserere7parada, comercioFarmacity,
						comercioLoDeJuan, CGPComuna1, BancoPatagonia)
	}
	
}
