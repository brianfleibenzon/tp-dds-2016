package edu.tp2016.observersBusqueda

import edu.tp2016.servidores.ServidorLocal

class CantidadDeResultadosObserver implements BusquedaObserver{

override def void registrarBusqueda(String texto, RegistroDeBusqueda busqueda, ServidorLocal servidor){
		
		val cantidadRetornadaDePois = (servidor.buscarPor(texto)).size

		busqueda.cantidadDeResultados = cantidadRetornadaDePois
	}
}