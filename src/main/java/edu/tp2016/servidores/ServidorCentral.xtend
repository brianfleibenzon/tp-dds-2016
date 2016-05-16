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
import org.joda.time.LocalDateTime

@Accessors
class ServidorCentral {

	List<ExternalServiceAdapter> interfacesExternas = new ArrayList<ExternalServiceAdapter>
	List<BusquedaObserver> busquedaObservers
	long tiempoLimiteDeBusqueda
	Repositorio repo = Repositorio.newInstance
	List<ServidorLocal> servidoresLocales
	List<RegistroDeBusqueda> busquedas = new ArrayList<RegistroDeBusqueda>
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

	
	def List<POI> buscarEnRepoCentral(String texto, RegistroDeBusqueda busquedaActual) {
		
		busquedaObservers.forEach [ observer | observer.registrarBusqueda(texto, busquedaActual, this) ]
		busquedas.add(busquedaActual)
		
		Arrays.asList(Lists.newArrayList(this.buscarPor(texto)))
		
	}
	
	def inicializarTiempoLimiteDeBusqueda(int tiempo){
		tiempoLimiteDeBusqueda = tiempo
	} // De esta forma es parametizable
	
	def agregarServidorLocal(ServidorLocal servidor){
		servidoresLocales.add(servidor)
	}
	
	def adscribirObserver(BusquedaObserver observadores){
		busquedaObservers.addAll(observadores)
	}
	
	def quitarObserver(BusquedaObserver observadores){
		busquedaObservers.removeAll(observadores)
	}
		
		// REPORTES DE BÚSQUEDAS:
			
		def generarReporteCantidadTotalDeBusquedasPorFecha() {
		val HashMap<LocalDateTime, Integer> reporte = new HashMap<LocalDateTime, Integer>()

		busquedas.forEach [ busqueda |
			if (reporte.containsKey(busqueda.fecha)) {
				reporte.put(busqueda.fecha, reporte.get(busqueda.fecha) + 1)
			} else {
				reporte.put(busqueda.fecha, 1)
			}
		]

		reporte
	}
	
	def generarReporteCantidadDeResultadosParcialesPorTerminal() {
		val HashMap<String, List<Integer>> reporte = new HashMap<String, List<Integer>>()

		busquedas.forEach [ busqueda |

			if (!reporte.containsKey(busqueda.nombreTerminal)) {
				reporte.put(busqueda.nombreTerminal, new ArrayList<Integer>)
			}
			reporte.get(busqueda.nombreTerminal).add(busqueda.cantidadDeResultados)

		]

		reporte
	}
	

	def generarReporteCantidadDeResultadosParcialesDeUnaTerminalEspecifica(String nombreDeConsulta) {
		val List<Integer> reporte = new ArrayList<Integer>
		
		val busquedasDeLaTerminal = busquedas.filter [ busqueda | (busqueda.nombreTerminal).equals(nombreDeConsulta) ]
		
		busquedasDeLaTerminal.forEach [ busqueda | reporte.add(busqueda.cantidadDeResultados)
		]
		
		reporte
	}

	def generarReporteCantidadTotalDeResultadosPorTerminal() {
		val HashMap<String, Integer> reporte = new HashMap<String, Integer>()

		busquedas.forEach [ busqueda |
			
			if (reporte.containsKey(busqueda.nombreTerminal)) {
				reporte.put(busqueda.nombreTerminal, reporte.get(busqueda.nombreTerminal) + busqueda.cantidadDeResultados)
			} else {
				reporte.put(busqueda.nombreTerminal, busqueda.cantidadDeResultados)
			}			

		]

		reporte
	}

}