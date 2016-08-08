package edu.tp2016.buscador

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import edu.tp2016.pois.POI
import org.joda.time.LocalDateTime
import java.util.ArrayList
import com.google.common.collect.Lists
import org.joda.time.Duration
import edu.tp2016.serviciosExternos.ExternalServiceAdapter
import edu.tp2016.repositorio.Repositorio
import edu.tp2016.observersBusqueda.Busqueda
import java.util.HashMap
import edu.tp2016.usuarios.Administrador
import edu.tp2016.usuarios.Usuario
import org.joda.time.LocalDate
import edu.tp2016.serviciosExternos.MailSender
import org.uqbar.commons.utils.Observable
import edu.tp2016.usuarios.Terminal
import edu.tp2016.builder.ParadaBuilder
import java.util.Arrays
import edu.tp2016.mod.DiaDeAtencion
import org.uqbar.geodds.Point
import edu.tp2016.builder.ComercioBuilder
import edu.tp2016.mod.Rubro
import org.uqbar.commons.model.IModel

@Observable
@Accessors
class Buscador implements IModel<Buscador>{
	List<POI> resultados = new ArrayList<POI> // para UI
	POI poiSeleccionado // para UI
	String busqueda // para UI
	boolean initStatus = false // para UI
	/*-----------------------------------------------------------------------------------*/
	List<ExternalServiceAdapter> interfacesExternas = new ArrayList<ExternalServiceAdapter>
	public Repositorio repo = Repositorio.newInstance
	List<Busqueda> busquedas = new ArrayList<Busqueda>
	List<Administrador> administradores = new ArrayList<Administrador>
	Usuario usuarioActual
	LocalDateTime fechaActual
	MailSender mailSender
	
	new(){
		fechaActual = new LocalDateTime()
	}
	
	override Buscador getSource(){
		this
	}
	
	def init(){
		if(!initStatus){
			usuarioActual = new Terminal("terminal")
			repo.agregarVariosPois(crearJuegoDeDatos())
			initStatus = true
		}
	}

	def boolean consultarCercania(POI unPoi, POI otroPoi) {
		unPoi.estaCercaA(otroPoi.ubicacion)
	}

	def boolean consultarDisponibilidad(POI unPoi, String texto) {
		unPoi.estaDisponible(fechaActual, texto)
	}
	
	def List<POI> buscar(String texto){
		val t1 = new LocalDateTime()
		val listaDePoisDevueltos = Lists.newArrayList(this.buscarPor(texto))
		val t2 = new LocalDateTime()
		
		val demora = (new Duration(t1.toDateTime, t2.toDateTime)).standardSeconds
		
		usuarioActual.registrarBusqueda(texto, listaDePoisDevueltos, demora, this)

		listaDePoisDevueltos
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

		poisBusqueda.filter [poi | texto != null && !texto.isEmpty &&
			(poi.tienePalabraClave(texto) || poi.coincide(texto))
		]
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
	def generarReporteCantidadTotalDeBusquedasPorFecha() {
		val reporte = new HashMap<LocalDate, Integer>()

		busquedas.forEach [ busqueda |

			val date = busqueda.fecha.toLocalDate

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

			if (!reporte.containsKey(busqueda.nombreUsuario)) {
				reporte.put(busqueda.nombreUsuario, new ArrayList<Integer>)
			}
			reporte.get(busqueda.nombreUsuario).add(busqueda.cantidadDeResultados)
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

			if (reporte.containsKey(busqueda.nombreUsuario)) {
				val cantidadAcumulada = reporte.get(busqueda.nombreUsuario) + cantResultados

				reporte.put(busqueda.nombreUsuario, cantidadAcumulada)
			} else {
				reporte.put(busqueda.nombreUsuario, cantResultados)
			}
		]
		reporte
	}
	
	def crearJuegoDeDatos(){
		val ubicacionX = new Point(-1, 1)
		val rangoX = new ArrayList<DiaDeAtencion>

		val utn7parada = new ParadaBuilder().nombre("7_utn").
		ubicacion(ubicacionX).
		claves( Arrays.asList("utn", "campus", "coletivo", "parada")).build

		val miserere7parada = new ParadaBuilder().nombre("7_once").
		ubicacion(ubicacionX).
		claves(Arrays.asList("utn", "plaza miserere", "once", "coletivo", "parada")).build

		val utn114parada = new ParadaBuilder().nombre("114_utn").
		ubicacion(ubicacionX).
		claves(Arrays.asList("utn", "campus", "coletivo", "parada")).build

		val rubroFarmacia = new Rubro("Farmacia", 1)

		val rubroLibreria = new Rubro("Libreria", 2)
	
	    val comercioFarmacity = new ComercioBuilder().nombre("Farmacity").
		ubicacion(ubicacionX).
		claves(Arrays.asList("medicamentos", "salud")).
		rubro(rubroFarmacia).
		rango(rangoX).build

		val comercioLoDeJuan = new ComercioBuilder().nombre("Libreria Juan").
		ubicacion(ubicacionX).
		claves(Arrays.asList("fotocopias", "utiles", "libros")).
		rubro(rubroLibreria).
		rango(rangoX).build
	
		val pois = Lists.newArrayList(utn7parada,
								  utn114parada,
								  miserere7parada,
								  comercioFarmacity,
								  comercioLoDeJuan)
		pois
	} // para UI
	
	def buscar(){
		init
		resultados = buscar(busqueda)
	} // para UI
	

}