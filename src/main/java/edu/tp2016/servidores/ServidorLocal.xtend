package edu.tp2016.servidores

import org.uqbar.geodds.Point
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import com.google.common.collect.Lists //Importada a través de una dependencia en el 'pom'.
import java.util.Arrays
import java.util.ArrayList
import edu.tp2016.pois.POI
import edu.tp2016.repositorio.Repositorio
import edu.tp2016.serviciosExternos.ExternalServiceAdapter
import edu.tp2016.observersBusqueda.BusquedaObserver
import edu.tp2016.observersBusqueda.RegistroDeBusqueda
import org.joda.time.LocalDateTime

@Accessors
class ServidorLocal{
	
	ServidorCentral servidorCentral //por ahora nada
	List<ExternalServiceAdapter> interfacesExternas = new ArrayList<ExternalServiceAdapter>
	Repositorio repo = Repositorio.newInstance
	List<BusquedaObserver> busquedaObservers
	List<RegistroDeBusqueda> busquedas = new ArrayList<RegistroDeBusqueda>
	long tiempoLimiteDeBusqueda
	String nombreTerminal

	new(List<POI> listaPois, String terminal) {
		repo.agregarPois(listaPois)
		nombreTerminal = terminal
	}
	
	def inicializarTiempoLimiteDeBusqueda(int tiempo){
		tiempoLimiteDeBusqueda = tiempo
	} // de esta forma es parametizable
	
	def adscribirObserver(BusquedaObserver observador){
		busquedaObservers.add(observador)
	}
	
	def quitarObserver(BusquedaObserver observador){
		busquedaObservers.remove(observador)
	}

	def boolean consultarCercania(POI unPoi, Point ubicacion) {
		unPoi.estaCercaA(ubicacion)
	}


	def boolean consultarDisponibilidad(POI unPoi, String valorX) {
		val fechaActual = new LocalDateTime
		unPoi.estaDisponible(fechaActual,valorX)
	}

	def void obtenerPoisDeInterfacesExternas(String texto, List<POI> poisBusqueda) {
		interfacesExternas.forEach [ unaInterfaz |
			poisBusqueda.addAll(unaInterfaz.buscar(texto))
		]
	}

	def Iterable<POI> buscarPor(String texto) {
		val poisBusqueda = new ArrayList<POI>
		poisBusqueda.addAll(repo.allInstances)

		obtenerPoisDeInterfacesExternas(texto, poisBusqueda)

		poisBusqueda.filter[poi|!texto.equals("") && (poi.tienePalabraClave(texto) || poi.coincide(texto))]

	}

	/**
	 *  Dado que el filter retorna una colección de tipo ITERATOR, en este método se convierte la colección
	 *  de ITERARTOR a ARRAYLIST, y finamente de ARRAYLIST a LIST, que es el tipo que usamos.
	 */
	def List<POI> buscar(String texto) {
	
		val busquedaActual = new RegistroDeBusqueda(new LocalDateTime, nombreTerminal)
		busquedaObservers.forEach [ observer | observer.registrarBusqueda(texto, busquedaActual, this) ]
		busquedas.add(busquedaActual)
		
		Arrays.asList(Lists.newArrayList(this.buscarPor(texto)))
		
	}
	
}