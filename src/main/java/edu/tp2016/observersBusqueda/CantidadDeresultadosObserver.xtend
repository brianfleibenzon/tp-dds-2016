package edu.tp2016.observersBusqueda

import edu.tp2016.servidores.servidorLocal
import edu.tp2016.observersBusqueda.RegistroDeBusqueda

class CantidadDeresultadosObserver extends BusquedaObserver{
	
	override def void registrarBusqueda(String texto, RegistroDeBusqueda busqueda, ServidorLocal servidor){
		
		val cantidadRetornada = (servidor.buscarPor(texto)).size

		busqueda.cantidadDeResultados = cantidadRetornada
	}
	}