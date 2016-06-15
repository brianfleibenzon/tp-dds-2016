package edu.tp2016.procesos

import edu.tp2016.pois.POI
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ActualizacionDeLocalesComerciales extends Proceso {
	String[] textoParaFiltrarNombre
	String [] textoParaFiltrarPalabrasClave
	List<POI> POIS = new ArrayList<POI>
	String textoParaActualizarComercios

	override correr() {

		// split filtra el string hasta que encuentra el caracter pasado
		textoParaFiltrarNombre = textoParaActualizarComercios.split(";")
		textoParaFiltrarPalabrasClave = textoParaFiltrarNombre.get(1).split(" ")

		POIS.addAll(servidor.buscarPor(textoParaFiltrarNombre.get(0).toString()))

		POIS.forEach [ unPoi |
			unPoi.palabrasClave.clear()
			unPoi.palabrasClave.addAll(textoParaFiltrarPalabrasClave)

		]
	// servidor.actualizaPOI(POIS)
	/*for (String textoParaFiltrarPalabrasClave : textoParaFiltrarPalabrasClave) {

	 * 	POIS.forEach[unPOI|unPOI.agregarPalabraClave(textoParaFiltrarPalabrasClave)]

	 * 	servidor.actualizaPOI(POIS)
	 }*/
	}
}
