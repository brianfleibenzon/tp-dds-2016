package edu.tp2016.usuarios

import org.uqbar.geodds.Point
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.pois.POI
import org.joda.time.LocalDateTime
import java.util.ArrayList
import com.google.common.collect.Lists
import edu.tp2016.observersBusqueda.BusquedaObserver
import org.joda.time.Duration
import edu.tp2016.serviciosExternos.ExternalServiceAdapter
import edu.tp2016.repositorio.Repositorio
import edu.tp2016.observersBusqueda.Busqueda
import edu.tp2016.procesos.ResultadoDeDarDeBajaUnPoi
import edu.tp2016.serviciosExternos.MailSender
import java.util.HashMap
import java.util.Date

@Accessors
class Terminal implements Cloneable{
	
	List<ExternalServiceAdapter> interfacesExternas = new ArrayList<ExternalServiceAdapter>
	Repositorio repo = Repositorio.newInstance
	List<Terminal> terminales = new ArrayList<Terminal>
	List<Busqueda> busquedas = new ArrayList<Busqueda>
	List<Administrador> administradores = new ArrayList<Administrador>
	Administrador administrador // Para Entrega 3 (único administrador)
	MailSender mailSender
	List<ResultadoDeDarDeBajaUnPoi> poisDadosDeBaja = new ArrayList<ResultadoDeDarDeBajaUnPoi>
	String nombreTerminal
	Point ubicacion
	LocalDateTime fechaActual
	List<BusquedaObserver> busquedaObservers = new ArrayList<BusquedaObserver>
	
/**
	 * Constructor para una Terminal (léase Usuario). La creo con su nombre (ej.: "terminalAbasto").
	 * 
	 * @param
	 * @return una terminal
	 */

	new(Point _ubicacion, String terminal) {
		ubicacion = _ubicacion
		nombreTerminal = terminal
		fechaActual = new LocalDateTime
	}

/**
	 * Constructor para una Terminal (léase Usuario). La creo con su nombre (ej.: "terminalAbasto").
	 * Le tengo que indicar la fecha actual.
	 * 
	 * @param
	 * @return una terminal con fecha actual parametrizable
	 */
	new(Point _ubicacion, String terminal, LocalDateTime _fecha) {
		ubicacion = _ubicacion
		nombreTerminal = terminal
		fechaActual = _fecha
	} // Constructor con fecha parametrizable (solo para test de Disponibilidad)
	
	new(String name, List<BusquedaObserver> observers) {
		nombreTerminal = name
		busquedaObservers.clear
		busquedaObservers.addAll(observers)
	} // Constructor para la clonación de una Terminal
	
	def adscribirObserver(BusquedaObserver observador){
		busquedaObservers.add(observador)
	}
	
	def quitarObserver(BusquedaObserver observador){
		busquedaObservers.remove(observador)
	}

	def boolean consultarCercania(POI unPoi) {
		unPoi.estaCercaA(ubicacion)
	}

	def boolean consultarDisponibilidad(POI unPoi, String textoX) {
		unPoi.estaDisponible(fechaActual, textoX)
	}
	
	def List<POI> buscar(String texto){
		
		val t1 = new LocalDateTime()
		val listaDePoisDevueltos = Lists.newArrayList(this.buscarPor(texto))
		val t2 = new LocalDateTime()
		
		val demora = (new Duration(t1.toDateTime, t2.toDateTime)).standardSeconds
		
		busquedaObservers.forEach [ observer |
			observer.registrarBusqueda(texto, listaDePoisDevueltos, demora, this) ]

		listaDePoisDevueltos
	}
    
    def clonar(){
    	val usuarioClon = new Terminal(nombreTerminal, busquedaObservers)
	    
	    return usuarioClon
    }
    
    def copyFrom(Terminal usuarioBefore){
		busquedaObservers.clear
		busquedaObservers.addAll(usuarioBefore.busquedaObservers)
    }
    
    new(List<POI> listaPois) {
		listaPois.forEach [ poi | repo.agregarPoi(poi)]
	}
	
	def registrarPOI(POI poi){
		repo.agregarPoi(poi)
	}

	def void obtenerPoisDeInterfacesExternas(String texto, List<POI> poisBusqueda) {
		interfacesExternas.forEach [ unaInterfaz |
			poisBusqueda.addAll(unaInterfaz.buscar(texto))
		]
	}

// BÚSQUEDA EN EL REPOSITORIO:
	def Iterable<POI> buscarPor(String texto) {
		val poisBusqueda = new ArrayList<POI>
		poisBusqueda.addAll(repo.allInstances)

		obtenerPoisDeInterfacesExternas(texto, poisBusqueda)

		poisBusqueda.filter[poi|!texto.equals("") && (poi.tienePalabraClave(texto) || poi.coincide(texto))]
	}
	
	/**
	 * Devuelve el POI cuyo id se pasó como parámetro de búsqueda.
	 * Obs.: Busca en el repopsitorio de pois
	 * 
	 * @params id de un POI
	 * @return un POI
	 */
	def List<POI> buscarPorId(int _id) {
		val repoDePois = new ArrayList<POI>
		
		repoDePois.addAll(repo.allInstances)
		Lists.newArrayList( repoDePois.filter [poi | poi.id.equals(_id) ] )
	}
	
	def void registrarBusqueda(Busqueda unaBusqueda){
		busquedas.add(unaBusqueda)
	}

// REPORTES DE BÚSQUEDAS:
	/**
	 * Observación. Date es una fecha con el siguiente formato:
	 * public Date(int year, int month, int date)
	 * 
	 * @return reporte de búsquedas por fecha
	 */
	def generarReporteCantidadTotalDeBusquedasPorFecha() {
		val reporte = new HashMap<Date, Integer>()

		busquedas.forEach [ busqueda |

			val date = (busqueda.fecha).toDate

			if (reporte.containsKey(date)) {
				reporte.put(date, reporte.get(date) + 1)
			} else {
				reporte.put(date, 1)
			}
		]
		reporte
	}

	def generarReporteCantidadDeResultadosParcialesPorTerminal() {
		val reporte = new HashMap<String, List<Integer>>()

		busquedas.forEach [ busqueda |

			if (!reporte.containsKey(busqueda.nombreTerminal)) {
				reporte.put(busqueda.nombreTerminal, new ArrayList<Integer>)
			}
			reporte.get(busqueda.nombreTerminal).add(busqueda.cantidadDeResultados)
		]
		reporte
	}

	def generarReporteCantidadDeResultadosParcialesDeUnaTerminalEspecifica(String nombreDeConsulta) {
		val reporte = generarReporteCantidadDeResultadosParcialesPorTerminal().get(nombreDeConsulta)
		
		reporte
	}

	def generarReporteCantidadTotalDeResultadosPorTerminal() {
		val reporte = new HashMap<String, Integer>()

		busquedas.forEach [ busqueda |

			val cantResultados = busqueda.cantidadDeResultados

			if (reporte.containsKey(busqueda.nombreTerminal)) {
				val cantidadAcumulada = reporte.get(busqueda.nombreTerminal) + cantResultados

				reporte.put(busqueda.nombreTerminal, cantidadAcumulada)
			} else {
				reporte.put(busqueda.nombreTerminal, cantResultados)
			}
		]
		reporte
	}
	
	def void actualizaPOI (List<POI> POIS){
		POIS.forEach[unPoi| repo.update(unPoi) ]
	}
	
	def registrarResultadoDeBaja(ResultadoDeDarDeBajaUnPoi resultado){
		poisDadosDeBaja.add(resultado)
	}
    
}