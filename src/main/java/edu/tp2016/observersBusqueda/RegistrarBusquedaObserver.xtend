package edu.tp2016.observersBusqueda

import java.util.List
import edu.tp2016.pois.POI
import edu.tp2016.usuarios.Usuario
import edu.tp2016.applicationModel.Buscador
import javax.persistence.Entity
import javax.persistence.DiscriminatorValue
import java.util.Set

@Entity
@DiscriminatorValue("1")
class RegistrarBusquedaObserver extends BusquedaObserver {

	override def void registrarBusqueda(List<String> criterios, Set<POI> poisDevueltos, long demora,
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
