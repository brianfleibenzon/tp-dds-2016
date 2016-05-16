package edu.tp2016.observersBusqueda

import edu.tp2016.observersBusqueda.RegistroDeBusqueda
import edu.tp2016.servidores.ServidorCentral

class FraseBuscadaObserver implements BusquedaObserver{
	
	override def void registrarBusqueda(String texto, RegistroDeBusqueda busqueda, ServidorCentral servidor){
		
		busqueda.textoBuscado = texto
	}
	
}