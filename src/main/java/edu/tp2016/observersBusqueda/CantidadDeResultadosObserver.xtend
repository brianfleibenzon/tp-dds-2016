package edu.tp2016.observersBusqueda

import edu.tp2016.servidores.ServidorCentral

class CantidadDeResultadosObserver implements BusquedaObserver{

override def void registrarBusqueda(String texto, RegistroDeBusqueda busqueda, ServidorCentral servidor){
		
		val cantidadRetornadaDePois = (servidor.buscarPor(texto)).size

		busqueda.cantidadDeResultados = cantidadRetornadaDePois
	}
}