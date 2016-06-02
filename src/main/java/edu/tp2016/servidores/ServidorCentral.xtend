package edu.tp2016.servidores

import java.util.HashMap
import edu.tp2016.observersBusqueda.Busqueda
import java.util.List
import edu.tp2016.pois.POI
import edu.tp2016.repositorio.Repositorio
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.serviciosExternos.ExternalServiceAdapter
import java.util.ArrayList
import java.util.Date
import edu.tp2016.usuarios.Administrador
import edu.tp2016.usuarios.Terminal
import edu.tp2016.serviciosExternos.MailSender

@Accessors
class ServidorCentral {

	List<ExternalServiceAdapter> interfacesExternas = new ArrayList<ExternalServiceAdapter>
	Repositorio repo = Repositorio.newInstance
	List<Terminal> servidoresLocales = new ArrayList<Terminal>
	List<Busqueda> busquedas = new ArrayList<Busqueda>
	List<Administrador> administradores = new ArrayList<Administrador>
	Administrador administrador // Para Entrega 3 (único administrador)
	MailSender mailSender

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

}
