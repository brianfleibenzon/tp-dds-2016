package edu.tp2016.sistema.decorators

import java.util.List
import edu.tp2016.pois.POI
import java.util.ArrayList
import org.joda.time.LocalDateTime
import org.joda.time.Duration
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.HashMap
import org.joda.time.LocalDate
import edu.tp2016.sistema.SistemaInterface
import edu.tp2016.sistema.Terminal

@Accessors
class SistemaConRegistroDeBusqueda extends SistemaDecorator{

	List<RegistroBusqueda> busquedas = new ArrayList<RegistroBusqueda>
	LocalDateTime fechaActual

	new(SistemaInterface _sistema) {
		super(_sistema)
	}

	override List<POI> buscar(String texto, Terminal terminal) {
		val LocalDateTime inicioBusqueda = new LocalDateTime()
		val list = sistema.buscar(texto, terminal)
		val LocalDateTime finBusqueda = new LocalDateTime()
		val tiempo = new Duration(inicioBusqueda.toDateTime, finBusqueda.toDateTime).standardSeconds
		if (terminal.activarGeneracionDeReportes){
			busquedas.add(new RegistroBusqueda(fechaActual.toLocalDate, terminal.nombreTerminal, texto, list.length, tiempo))
		}		
		list
	}

	def generarReportePorFecha() {
		val HashMap<LocalDate, Integer> reporte = new HashMap<LocalDate, Integer>()

		busquedas.forEach [ busqueda |
			if (reporte.containsKey(busqueda.fecha)) {
				reporte.put(busqueda.fecha, reporte.get(busqueda.fecha) + 1)
			} else {
				reporte.put(busqueda.fecha, 1)
			}

		]

		/*for (HashMap.Entry<LocalDate, Integer> entry : reporte.entrySet()) {
			System.out.println(entry.getKey().toString() + " : " + entry.getValue());
		}*/
		reporte
	}

	def generarReportePorTerminal() {
		val HashMap<String, List<Integer>> reporte = new HashMap<String, List<Integer>>()

		busquedas.forEach [ busqueda |

			if (!reporte.containsKey(busqueda.terminal)) {
				reporte.put(busqueda.terminal, new ArrayList<Integer>)
			}
			reporte.get(busqueda.terminal).add(busqueda.resultados)

		]

		reporte
	}

	def generarReporteTotal() {
		val HashMap<String, Integer> reporte = new HashMap<String, Integer>()

		busquedas.forEach [ busqueda |
			
			if (reporte.containsKey(busqueda.terminal)) {
				reporte.put(busqueda.terminal, reporte.get(busqueda.terminal) + busqueda.resultados)
			} else {
				reporte.put(busqueda.terminal, busqueda.resultados)
			}			

		]

		/*for (HashMap.Entry<String, Integer> entry : reporte.entrySet()) {
			System.out.println(entry.getKey() + " : " + entry.getValue());
		}*/
		reporte
	}

}
