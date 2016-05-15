package edu.tp2016.observersBusqueda

import edu.tp2016.servidores.ServidorLocal
import edu.tp2016.observersBusqueda.RegistroDeBusqueda

class FraseBuscadaObserver implements BusquedaObserver{
	
	override def void registrarBusqueda(String texto, RegistroDeBusqueda busqueda, ServidorLocal servidor){
		busqueda.textoBuscado = texto
	}
	
}