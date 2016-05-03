package edu.tp2016.interfacesExternas.banco;

import java.util.ArrayList;
import com.eclipsesource.json.JsonArray;

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
		
			listaSucursalesEncontradas.add(sucursal1);
			// Y así con sucursal 2 y sucursal3, que se pueden copiar del enunciado (se hace un addAll)
	
			System.out.println(listaSucursalesEncontradas);

	}
}
