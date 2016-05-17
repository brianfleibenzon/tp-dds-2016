package edu.tp2016.servidores

import java.util.HashMap
import edu.tp2016.observersBusqueda.RegistroDeBusqueda
import java.util.List
import edu.tp2016.pois.POI
import edu.tp2016.repositorio.Repositorio
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.observersBusqueda.BusquedaObserver
import com.google.common.collect.Lists
import edu.tp2016.serviciosExternos.ExternalServiceAdapter
import java.util.ArrayList
import org.joda.time.LocalDateTime

@Accessors
class ServidorCentral {

	List<ExternalServiceAdapter> interfacesExternas = new ArrayList<ExternalServiceAdapter>
	List<BusquedaObserver> busquedaObservers = new ArrayList<BusquedaObserver>
	long tiempoLimiteDeBusqueda
	Repositorio repo = Repositorio.newInstance
	List<ServidorLocal> servidoresLocales = new ArrayList<ServidorLocal> 
	List<RegistroDeBusqueda> busquedas = new ArrayList<RegistroDeBusqueda>
	String administradorMailAdress
	int buzonDeSalidaDeMails = 0
		
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
		
		val LocalDateTime t1 = new LocalDateTime()
		val listaDePoisDevueltos = Lists.newArrayList(this.buscarPor(texto))
		val LocalDateTime t2 = new LocalDateTime()
		
		busquedaObservers.forEach [ observer |
			observer.registrarBusqueda(texto, busquedaActual, listaDePoisDevueltos, t1, t2, this) ]
		
		listaDePoisDevueltos

	}
	
	/**
	 * Esta función le permite al ServidorCentral mapearse las búsquedas de cada terminal
	 * a partir de su lista de terminales (servidoresLocales), para luego destinarlas a un reporte en particular.
	 * Para ello se seleccionan primero aquellas terminales que estén habilitadas para generar reportes.
	 * 
	 * @return lista con búsquedas de todas las terminales
	 */
	
	def List<RegistroDeBusqueda> obtenerBusquedasDeTerminalesAReportar(){
		val busquedasTerminales = new ArrayList<RegistroDeBusqueda>
		val registrosPorTerminal = ( servidoresLocales
				.filter [terminal | (terminal.puedeGenerarReportes).equals(true) ]
				.map [terminal | terminal.busquedasTerminal ] )
		
		registrosPorTerminal.forEach [ registro | busquedasTerminales.addAll(registro) ]
		
		busquedasTerminales
	}
	
	def inicializarTiempoLimiteDeBusqueda(long tiempo){
		tiempoLimiteDeBusqueda = tiempo.longValue()
	}
	
	def agregarServidorLocal(ServidorLocal terminal){
		servidoresLocales.add(terminal)
	}
	
	def adscribirObserver(BusquedaObserver observador){
		busquedaObservers.add(observador)
	}
	
	def quitarObserver(BusquedaObserver observador){
		busquedaObservers.remove(observador)
	}
		
// REPORTES DE BÚSQUEDAS:
			
	def generarReporteCantidadTotalDeBusquedasPorFecha() {
		val HashMap<LocalDateTime, Integer> reporte = new HashMap<LocalDateTime, Integer>()
		val busquedas = obtenerBusquedasDeTerminalesAReportar
		
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
		val busquedas = obtenerBusquedasDeTerminalesAReportar
		
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
		val busquedas = obtenerBusquedasDeTerminalesAReportar
		
		val busquedasDeLaTerminalEspecifica = ( busquedas
				.filter [ busqueda | (busqueda.nombreTerminal).equals(nombreDeConsulta) ] )
		
		busquedasDeLaTerminalEspecifica.forEach [ busqueda | reporte.add(busqueda.cantidadDeResultados)
		]
		
		reporte
	}

	def generarReporteCantidadTotalDeResultadosPorTerminal() {
		val HashMap<String, Integer> reporte = new HashMap<String, Integer>()
		val busquedas = obtenerBusquedasDeTerminalesAReportar
		
		busquedas.forEach [ busqueda |
			
				if (reporte.containsKey(busqueda.nombreTerminal)) {
				reporte.put(busqueda.nombreTerminal,
					reporte.get(busqueda.nombreTerminal) + busqueda.cantidadDeResultados
				)
			} else {
				reporte.put(busqueda.nombreTerminal, busqueda.cantidadDeResultados)
			}
		]
		reporte
	}

}