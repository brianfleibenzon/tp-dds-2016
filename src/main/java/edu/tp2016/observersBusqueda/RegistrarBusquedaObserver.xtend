package edu.tp2016.observersBusqueda

import edu.tp2016.observersBusqueda.Busqueda
import java.util.List
import edu.tp2016.pois.POI
import edu.tp2016.usuarios.Usuario
import org.joda.time.LocalDateTime

class RegistrarBusquedaObserver implements BusquedaObserver {

	override def void registrarBusqueda(String texto, List<POI> poisDevueltos, long demora,
		Usuario usuario) {
	
		val busqueda = new Busqueda()
		busqueda.nombreUsuario = usuario.userName
		busqueda.fecha = new LocalDateTime()
		busqueda.cantidadDeResultados = poisDevueltos.size
		busqueda.textoBuscado = texto
		busqueda.demoraConsulta = demora
		// terminal.registrarBusqueda(busqueda) TODO
	}	

}
