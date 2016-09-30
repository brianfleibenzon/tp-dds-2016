package edu.tp2016.observersBusqueda

import java.util.List
import edu.tp2016.pois.POI
import edu.tp2016.usuarios.Usuario
import edu.tp2016.applicationModel.Buscador

interface BusquedaObserver {

	def void registrarBusqueda(List<String> criterios, List<POI> poisDevueltos, long demora,
		Usuario usuario, Buscador buscador)
		
}
