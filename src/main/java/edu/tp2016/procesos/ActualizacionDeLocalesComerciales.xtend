package edu.tp2016.procesos

import edu.tp2016.pois.POI
import edu.tp2016.servidores.ServidorCentral
import java.util.List

class ActualizacionDeLocalesComerciales extends Proceso {
	String[] textoParaFiltrarNombre
	String [] textoParaFiltrarPalabrasClave
	ServidorCentral servidor
	List <POI> POIS
	
	def void actualizarComercio(String textoParaActualizarComercios){
		
		//split filtra el string hasta que encuentra el caracter pasado
		textoParaFiltrarNombre = textoParaActualizarComercios.split(";")
		textoParaFiltrarPalabrasClave =textoParaActualizarComercios.split(" ")	
			
		POIS=servidor.buscarPor(textoParaFiltrarNombre.toString()).toList()
		
		
		POIS.forEach[unPoi |unPoi.palabrasClave.clear()]
		for (String textoParaFiltrarPalabrasClave:textoParaFiltrarPalabrasClave){
		
		POIS.forEach[unPOI|unPOI.agregarPalabraClave(textoParaFiltrarPalabrasClave)]
		
		servidor.actualizaPOI(POIS)
		}
		
	}
}