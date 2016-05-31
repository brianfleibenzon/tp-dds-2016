package edu.tp2016.observersBusqueda

import edu.tp2016.servidores.ServidorCentral
import java.util.List
import edu.tp2016.pois.POI
import edu.tp2016.usuarios.Terminal

interface BusquedaObserver {

	def void registrarBusqueda(String texto, List<POI> poisDevueltos, long demora,
		Terminal terminal, ServidorCentral servidor)

}
