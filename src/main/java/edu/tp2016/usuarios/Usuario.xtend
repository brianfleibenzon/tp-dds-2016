package edu.tp2016.usuarios

import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.observersBusqueda.BusquedaObserver
import java.util.List
import java.util.ArrayList
import edu.tp2016.pois.POI
import edu.tp2016.applicationModel.Buscador

@Accessors
abstract class Usuario implements Cloneable {
	String userName
	String password
	String mailAdress
	List<BusquedaObserver> busquedaObservers = new ArrayList<BusquedaObserver>
	
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

}