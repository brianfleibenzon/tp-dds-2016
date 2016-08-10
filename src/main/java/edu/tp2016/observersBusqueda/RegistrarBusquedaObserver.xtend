package edu.tp2016.observersBusqueda

import java.util.List
import edu.tp2016.pois.POI
import edu.tp2016.usuarios.Usuario
import edu.tp2016.applicationModel.Buscador

class RegistrarBusquedaObserver implements BusquedaObserver {

	override def void registrarBusqueda(List<String> criterios, List<POI> poisDevueltos, long demora,
		Usuario usuario, Buscador buscador) {
	
		val busqueda = new Busqueda()
		busqueda.nombreUsuario = usuario.userName
		busqueda.fecha = buscador.fechaActual
		busqueda.cantidadDeResultados = poisDevueltos.size
		busqueda.palabrasBuscadas.addAll(criterios)
		busqueda.demoraConsulta = demora
		buscador.registrarBusqueda(busqueda) 
	}

}
