package edu.tp2016.servidores

import java.util.Map
import java.util.HashMap
import edu.tp2016.observersBusqueda.RegistroDeBusqueda
import java.util.List
import edu.tp2016.pois.POI
import edu.tp2016.repositorio.Repositorio
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.observersBusqueda.BusquedaObserver
import java.util.Arrays
import com.google.common.collect.Lists
import edu.tp2016.serviciosExternos.ExternalServiceAdapter
import java.util.ArrayList

@Accessors
class ServidorCentral {

	List<ExternalServiceAdapter> interfacesExternas = new ArrayList<ExternalServiceAdapter>
	List<BusquedaObserver> busquedaObservers
	long tiempoLimiteDeBusqueda
	Repositorio repo = Repositorio.newInstance
	List<ServidorLocal> servidoresLocales
	Map<Integer, String> busquedasPorTerminal = new HashMap<Integer, String>() // VER
		
	new(List<POI> listaPois) {
		repo.agregarPois(listaPois)
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
	def List<POI> buscarEnRepoCentral(String texto, RegistroDeBusqueda busquedaActual) {
		
		busquedaObservers.forEach [ observer | observer.registrarBusqueda(texto, busquedaActual, this) ]
		
		Arrays.asList(Lists.newArrayList(this.buscarPor(texto)))
		
	}
	
	def inicializarTiempoLimiteDeBusqueda(int tiempo){
		tiempoLimiteDeBusqueda = tiempo
	} // De esta forma es parametizable
	
	def agregarServidorLocal(ServidorLocal servidor){
		servidoresLocales.add(servidor)
	}
	
	def adscribirObserver(BusquedaObserver observador){
		busquedaObservers.add(observador)
	}
	
	def quitarObserver(BusquedaObserver observador){
		busquedaObservers.remove(observador)
	}
		
	def registrarBusquedaDeTerminal(RegistroDeBusqueda busqueda){
			
	}

}