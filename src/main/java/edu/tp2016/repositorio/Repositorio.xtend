package edu.tp2016.repositorio

import org.uqbar.commons.model.CollectionBasedRepo
import edu.tp2016.pois.POI
import org.apache.commons.collections15.Predicate
import org.apache.commons.collections15.functors.AndPredicate
import java.util.List

class Repositorio extends CollectionBasedRepo<POI> {

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

	def agregarPois(List<POI> pois){
		pois.forEach[poi | this.create(poi)]
	}
	
}
