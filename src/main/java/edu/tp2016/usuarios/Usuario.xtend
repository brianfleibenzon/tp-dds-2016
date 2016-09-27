package edu.tp2016.usuarios

import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.observersBusqueda.BusquedaObserver
import java.util.List
import java.util.ArrayList
import edu.tp2016.pois.POI
import edu.tp2016.applicationModel.Buscador
import org.uqbar.commons.model.Entity
import org.uqbar.commons.utils.Observable
import org.uqbar.geodds.Point
import java.util.HashSet
import java.util.Set

@Observable
@Accessors
abstract class Usuario extends Entity implements Cloneable {
	String userName
	String password
	String mailAdress
	List<BusquedaObserver> busquedaObservers = new ArrayList<BusquedaObserver>
	Point ubicacionActual
	Set<POI> poisFavoritos = new HashSet<POI>
	//List<POI> poisFavoritos = new ArrayList<POI>
	
	new(){ } // Constructor default de la superclase
	
	def adscribirObserver(BusquedaObserver observador){
		busquedaObservers.add(observador)
	}
	
	def quitarObserver(BusquedaObserver observador){
		busquedaObservers.remove(observador)
	}
	
	def registrarBusqueda(List<String> criterios, List<POI> poisDevueltos, long demora, Buscador buscador){
		busquedaObservers.forEach [ observer |
			observer.registrarBusqueda(criterios, poisDevueltos, demora, this, buscador) ]
	}
	
	def tienePoiFavorito(POI poi){
		poisFavoritos.contains(poi)
	}
	
	def modificarPoiFavorito(POI poi, Boolean esFavorito){
		if (esFavorito){
			poisFavoritos.add(poi)
		}else{
			poisFavoritos.remove(poi)
		}
	}

}