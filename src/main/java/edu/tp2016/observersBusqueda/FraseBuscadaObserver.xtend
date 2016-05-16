package edu.tp2016.observersBusqueda

import edu.tp2016.observersBusqueda.RegistroDeBusqueda
import edu.tp2016.servidores.ServidorCentral
import java.util.List
import edu.tp2016.pois.POI
import org.joda.time.LocalDateTime

class FraseBuscadaObserver implements BusquedaObserver{
	
	override def void registrarBusqueda(String texto, RegistroDeBusqueda busqueda, List<POI> poisDevueltos,
			LocalDateTime t1, LocalDateTime t2,ServidorCentral servidor){
		
		busqueda.textoBuscado = texto
	}
	
}