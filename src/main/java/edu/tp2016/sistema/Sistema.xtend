package edu.tp2016.sistema

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import com.google.common.collect.Lists //Importada a través de una dependencia en el 'pom'.
import java.util.Arrays
import org.joda.time.LocalDateTime
import java.util.ArrayList
import edu.tp2016.pois.POI
import edu.tp2016.repositorio.Repositorio
import edu.tp2016.serviciosExternos.ExternalServiceAdapter

@Accessors
class Sistema implements SistemaInterface{
	LocalDateTime fechaActual
	List<ExternalServiceAdapter> interfacesExternas = new ArrayList<ExternalServiceAdapter>
	Repositorio repo = Repositorio.newInstance
	List<Terminal> terminales = new ArrayList<Terminal> 

	new(List<POI> listaPois, LocalDateTime unaFecha) {
		repo.agregarPois(listaPois)
		fechaActual = unaFecha
	}

	def void obtenerPoisDeInterfacesExternas(String texto, List<POI> poisBusqueda) {
		interfacesExternas.forEach [ unaInterfaz |
			poisBusqueda.addAll(unaInterfaz.buscar(texto))
		]
	}

	def Iterable<POI> buscarPor(String texto) {
		val poisBusqueda = new ArrayList<POI>
		poisBusqueda.addAll(repo.allInstances)

		obtenerPoisDeInterfacesExternas(texto, poisBusqueda)

		poisBusqueda.filter[poi|!texto.equals("") && (poi.tienePalabraClave(texto) || poi.coincide(texto))]

	}

	/**
	 *  Dado que el filter retorna una colección de tipo ITERATOR, en este método se convierte la colección
	 *  de ITERARTOR a ARRAYLIST, y finamente de ARRAYLIST a LIST, que es el tipo que usamos.
	 */
	override List<POI> buscar(String texto, Terminal terminal) {
		Arrays.asList(Lists.newArrayList(this.buscarPor(texto)))
	}

}
