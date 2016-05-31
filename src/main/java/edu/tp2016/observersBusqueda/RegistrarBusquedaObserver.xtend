package edu.tp2016.observersBusqueda

import edu.tp2016.observersBusqueda.Busqueda
import edu.tp2016.servidores.ServidorCentral
import java.util.List
import edu.tp2016.pois.POI
import edu.tp2016.usuarios.Terminal

class RegistrarBusquedaObserver implements BusquedaObserver {

	override def void registrarBusqueda(String texto, List<POI> poisDevueltos, long demora,
		Terminal terminal, ServidorCentral servidor) {
	
		val busqueda = new Busqueda()
		busqueda.nombreTerminal = terminal.nombreTerminal
		busqueda.fecha = terminal.fechaActual
		busqueda.cantidadDeResultados = poisDevueltos.size
		busqueda.textoBuscado = texto
		busqueda.demoraConsulta = demora
		servidor.registrarBusqueda(busqueda)
	}	

}
