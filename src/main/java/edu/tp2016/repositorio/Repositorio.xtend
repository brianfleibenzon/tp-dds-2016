package edu.tp2016.repositorio

import org.uqbar.commons.model.CollectionBasedRepo
import edu.tp2016.pois.POI
import org.apache.commons.collections15.Predicate
import org.apache.commons.collections15.functors.AndPredicate
import java.util.Random
import java.util.ArrayList
import edu.tp2016.procesos.ResultadoDeDarDeBajaUnPoi
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Repositorio extends CollectionBasedRepo<POI> {
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

	override getCriterioTodas() {
		[POI poi|true] as Predicate<POI>
	}

	def getCriterioPorNombre(String nombre) {
		[POI poi|poi.coincide(nombre)] as Predicate<POI>
	}

	def getCriterioPorPalabraClave(String palabraClave) {
		[POI poi|poi.tienePalabraClave(palabraClave)] as Predicate<POI>
	}
//
//	def getCriterioPorParada(String parada) {
//		[POI poi|poi.coincide(parada)] as Predicate<POI>
//	}
//
//	def getCriterioPorServicio(String servicio) {
//		[POI poi|poi.coincide(servicio)] as Predicate<POI>
//	}
//
//	def getCriterioPorRubro(String rubro) {
//		[POI poi|poi.coincide(rubro)] as Predicate<POI>
//	}
	
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
	
	def boolean idEnUso(int id){
		!((allInstances.filter [ poi | poi.id.equals(id)]).isEmpty)
	}
	
	def eliminarPoi(POI poi){
		this.effectiveDelete(poi)
	}
	
	def void actualizaPOI (List<POI> POIS){
		POIS.forEach[unPoi| this.update(unPoi) ]
	}
	
	def registrarResultadoDeBaja(ResultadoDeDarDeBajaUnPoi resultado){
		this.poisDadosDeBaja.add(resultado)
	}
	
}
