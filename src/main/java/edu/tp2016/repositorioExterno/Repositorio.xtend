package edu.tp2016.repositorioExterno

import org.uqbar.commons.model.CollectionBasedRepo
import edu.tp2016.pois.POI
import org.apache.commons.collections15.Predicate
import org.apache.commons.collections15.functors.AndPredicate


abstract class Repositorio extends CollectionBasedRepo <POI> {
		/*Inicializo repositorio  */
		Repositorio repo= Repositorio.newInstance
		
		override createExample() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")

}

		
	override def getEntityType() {
		typeof(POI)
	}
	

	override def Predicate<POI> getCriterio(POI unPoi) {
		var result = this.criterioTodas
		if(unPoi.nombre != null){
			result = new AndPredicate(result,this.getCriterioPorNombre(unPoi.nombre))
		}
		result
	}
	
	override getCriterioTodas(){
		[POI poi | true] as Predicate<POI>
	}

	def getCriterioPorNombre(String nombre){
		[POI poi |poi.coincide(nombre)] as Predicate<POI>
	}
	def getCriterioPorPalabraClave(String palabraClave){
		[POI poi |poi.tienePalabraClave(palabraClave)] as Predicate <POI>
	}
	def getCriterioPorParada (String parada){
		[POI poi| poi.coincide(parada)] as Predicate <POI>
	}
	def getCriterioPorServicio(String servicio){
		[POI poi| poi.coincide(servicio)] as Predicate <POI>
	}
	def getCriterioPorRubro(String rubro){
		[POI poi| poi.coincide(rubro)] as Predicate <POI>
	}
}

