package edu.tp2016.procesos

import edu.tp2016.pois.POI
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.applicationModel.Buscador
import edu.tp2016.repositorio.RepoPois

@Accessors
class ActualizacionDeLocalesComerciales extends Proceso {
	String[] textoParaFiltrarNombre
	String [] textoParaFiltrarPalabrasClave
	List<POI> POIS = new ArrayList<POI>
	String textoParaActualizarComercios
	Buscador buscador

	new(Buscador nuevo_buscador){
		buscador = nuevo_buscador
	}

	override correr() {

		// split filtra el string hasta que encuentra el caracter pasado
		textoParaFiltrarNombre = textoParaActualizarComercios.split(";")
		textoParaFiltrarPalabrasClave = textoParaFiltrarNombre.get(1).split(" ")

		POIS.addAll(buscador.buscar(textoParaFiltrarNombre.get(0).toString()))

		POIS.forEach [ unPoi |
			unPoi.palabrasClave.clear()
			unPoi.palabrasClave.addAll(textoParaFiltrarPalabrasClave)
			RepoPois.instance.update(unPoi)
		]

	}
}
