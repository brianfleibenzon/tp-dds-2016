package edu.tp2016.applicationModel

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import edu.tp2016.pois.POI
import org.joda.time.LocalDateTime
import java.util.ArrayList
import com.google.common.collect.Lists
import org.joda.time.Duration
import edu.tp2016.serviciosExternos.ExternalServiceAdapter
import edu.tp2016.repositorio.RepoPois
import edu.tp2016.observersBusqueda.Busqueda
import java.util.HashMap
import edu.tp2016.usuarios.Administrador
import edu.tp2016.usuarios.Usuario
import org.joda.time.LocalDate
import edu.tp2016.serviciosExternos.MailSender
import org.uqbar.commons.utils.Observable
import java.util.Arrays
import org.uqbar.commons.model.IModel
import java.util.HashSet
import java.util.Set
import edu.tp2016.mod.Punto

@Observable
@Accessors
class Buscador implements IModel<Buscador>{
	List<POI> resultados = new ArrayList<POI>
	POI poiSeleccionado
	String nuevoCriterio = ""
	List<String> criteriosBusqueda = new ArrayList<String>
	String mensajeInvalido
	String criterioSeleccionado
	/*-----------------------------------------------------------------------------------*/
	List<ExternalServiceAdapter> interfacesExternas = new ArrayList<ExternalServiceAdapter>
	public RepoPois repo = RepoPois.getInstance
	List<Busqueda> busquedas = new ArrayList<Busqueda>
	List<Administrador> administradores = new ArrayList<Administrador>
	Usuario usuarioActual
	LocalDateTime fechaActual
	MailSender mailSender
	Punto ubicacion = new Punto(-34.6596291, -58.4681825) //Bartolome Mitre y Callao: (-34.607984, -58.392070) 
	
	new(){
		fechaActual = new LocalDateTime()
	}
	
	new(Usuario usuario){
		this.usuarioActual = usuario
		this.usuarioActual.ubicacionActual = ubicacion	
	}
	
	override Buscador getSource(){
		this
	}
	
	def init(){
		resultados.clear
		mensajeInvalido = ""
	}

// CONSULTAS:
	def boolean consultarCercania(POI unPoi, POI otroPoi) {
		unPoi.estaCercaA(otroPoi.ubicacion)
	}

	def boolean consultarDisponibilidad(POI unPoi, String texto) {
		unPoi.estaDisponible(fechaActual, texto)
	}
	
// BÚSQUEDA EN EL REPOSITORIO:
	def Set<POI> buscar(String texto){
		this.buscar(Arrays.asList(texto))
	}
	
	def Set<POI> buscar(List<String> criterios){
		val t1 = new LocalDateTime()
		
		val listaDePoisDevueltos = repo.buscar(criterios)
		
		criterios.forEach[
			obtenerPoisDeInterfacesExternas(it, listaDePoisDevueltos)
		]
		
		val t2 = new LocalDateTime()
		val demora = (new Duration(t1.toDateTime, t2.toDateTime)).standardSeconds
		usuarioActual.registrarBusqueda(criterios, listaDePoisDevueltos, demora, this)

		listaDePoisDevueltos
	}

	def void obtenerPoisDeInterfacesExternas(String texto, Set<POI> poisBusqueda) {
		interfacesExternas.forEach [ unaInterfaz |
			poisBusqueda.addAll(unaInterfaz.buscar(texto).filter [ poi | texto != null && !texto.isEmpty &&
				(poi.tienePalabraClave(texto) || poi.coincide(texto))
			])
		]
	}
	
	/**
	 * Devuelve el POI cuyo id se pasó como parámetro de búsqueda.
	 * Obs.: Busca en el repopsitorio de pois
	 * 
	 * @params id de un POI
	 * @return un POI
	 */
	def POI buscarPorId(long _id) {
		repo.get(_id)
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
		generarReporteCantidadDeResultadosParcialesPorTerminal().get(nombreDeConsulta)
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
	
// VISTA - USER INTERFACE:		
	def buscar(){
		init
		resultados.clear
		mensajeInvalido = ""
		
		if(criteriosBusqueda.isEmpty) mensajeInvalido = "<< Debe ingresar un criterio de búsqueda >>"
		
		val Set<POI> search = new HashSet<POI>(resultados)
		
		search.addAll(this.buscar(criteriosBusqueda))		
		
		if(search.isEmpty && !criteriosBusqueda.isEmpty) mensajeInvalido = "<< No se han encontrado resultados para su búsqueda >>"
		search.forEach[
			it.usuarioActual = usuarioActual
			it.favorito = usuarioActual.tienePoiFavorito(it)
		]
		
		resultados.addAll(search)		
	} // Búsqueda adaptada para la UI
	
	def eliminarTodosLosCriterios(){
		criteriosBusqueda.clear()
		mensajeInvalido = ""
	}
	
	def agregarCriterio(){
		mensajeInvalido = ""
		if (nuevoCriterio != ""){
			criteriosBusqueda.add(nuevoCriterio)
			nuevoCriterio = ""
		}
		else{
			mensajeInvalido = "<< Debe ingresar un criterio de búsqueda >>"
		}
	}
	
	def eliminarCriterio(){
		criteriosBusqueda.remove(criterioSeleccionado)
	}
	
	def void setPoiSeleccionado(POI unPoi){
		if(unPoi != null) poiSeleccionado = RepoPois.instance.get(unPoi.id)
	}
	
	def eliminarPoi(POI poi){
		repo.eliminarPoi(poi)
	}
	
}