package edu.tp2016.serviciosExternos.banco;

import java.util.ArrayList;
import com.eclipsesource.json.JsonArray;

import edu.tp2016.serviciosExternos.banco.SucursalBanco;

/* Esta clase no es utilizada en el proyecto, su objetivo es simplemente mostrar que el Servicio Externo
 * para la búsqueda de Bancos diseñado en el Stub realmente devuelve resultados en formato JSON.
 * 
 */
public class ImprimirArrayBancos {
	public static void main (String [ ] args) {
		 
		ArrayList<SucursalBanco> listaSucursalesEncontradas = new ArrayList<SucursalBanco>();
		
		SucursalBanco sucursal1 = new SucursalBanco();
			sucursal1.add("banco", "Santander Rio");
			sucursal1.add("x", -34.9338322);
			sucursal1.add("y", 71.348353);
			sucursal1.add("sucursal", "Balvanera");
			sucursal1.add("gerente", "María Luna");
		
		JsonArray listaServicios = new JsonArray();
			listaServicios.add("cobro cheques");
			listaServicios.add("depósitos");
			listaServicios.add("extracciones");
			listaServicios.add("seguros");
			listaServicios.add("créditos");
			sucursal1.add("servicios", listaServicios);
			
		SucursalBanco sucursal2 = new SucursalBanco();
			sucursal2.add("banco", "Banco de la Plaza");
			sucursal2.add("x", -35.9338322);
			sucursal2.add("y", 72.348353);
			sucursal2.add("sucursal", "Avellaneda");
			sucursal2.add("gerente", "Javier Loeschbor");
					
		JsonArray listaServicios2 = new JsonArray();
			listaServicios2.add("cobro cheques");
			listaServicios2.add("depósitos");
			listaServicios2.add("extracciones");
			listaServicios2.add("seguros");
			sucursal2.add("servicios", listaServicios2);
		
			listaSucursalesEncontradas.add(sucursal1);
			listaSucursalesEncontradas.add(sucursal2);
	
			System.out.println(listaSucursalesEncontradas);

	}
}
