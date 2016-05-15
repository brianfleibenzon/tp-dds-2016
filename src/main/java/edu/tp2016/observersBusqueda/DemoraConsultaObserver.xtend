package edu.tp2016.observersBusqueda

import edu.tp2016.servidores.ServidorLocal
import edu.tp2016.observersBusqueda.RegistroDeBusqueda
import org.joda.time.LocalDateTime
import org.joda.time.Duration

class DemoraConsultaObserver extends BusquedaObserver{
	
	override def void registrarBusqueda(String texto, RegistroDeBusqueda busqueda, ServidorLocal servidor){
		
	val LocalDateTime inicioBusqueda = new LocalDateTime()
 	servidor.buscar(texto)
 	val LocalDateTime finBusqueda = new LocalDateTime()
 	
 	val demora = new Duration(inicioBusqueda.toDateTime, finBusqueda.toDateTime).standardSeconds
 	if (demora > servidor.tiempoLimiteDeBusqueda){
 		//TODO: Notificar por correo al administrador
	}
	}
	
	}