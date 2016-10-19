package edu.tp2016.serviciosExternos

import java.util.ArrayList
import java.util.List

class StubServicioREST implements ServicioREST {
	
	List<String> listaPoisInactivos = new ArrayList<String>

	override List<String> obtenerPoisInactivos() {

		listaPoisInactivos

	}

	new() {}

	new(List<Long> ids) {
		ids.forEach[
			listaPoisInactivos.add("{\"id\":"+it+",\"fecha\":\"2016-02-10 11:01\"}")
		]
	}
}
