package edu.tp2016.repositorioExterno

import org.uqbar.commons.model.CollectionBasedRepo
import edu.tp2016.pois.POI

abstract class Repositorio extends CollectionBasedRepo <POI> {
		override createExample() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override getEntityType() {
		typeof(POI)
	}
	
	/**override protected getCriterio(POI example) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}**/
		
}

