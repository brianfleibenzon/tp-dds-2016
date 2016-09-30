package edu.tp2016.serviciosExternos

import java.util.List
import java.util.ArrayList

class StubServicioREST implements ServicioREST{
	
		override List<String> obtenerPoisInactivos(){
		val listaPoisInactivos = new ArrayList<String>
		
		// AGREGAR MÁS POIS DE EJEMPLO (PARA TESTS)
		
		val poi1 = "{\"id\":1,\"fecha\":\"2016-02-10 11:01\"}"
		val poi2 = "{\"id\":2,\"fecha\":\"2016-03-13 10:15\"}"
		val poi3 = "{\"id\":3,\"fecha\":\"2016-07-24 21:30\"}"
		
		listaPoisInactivos.addAll(poi1, poi2, poi3)
		
		listaPoisInactivos
	}
}