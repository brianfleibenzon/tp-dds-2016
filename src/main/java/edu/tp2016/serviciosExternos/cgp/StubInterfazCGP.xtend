package edu.tp2016.serviciosExternos.cgp

import edu.tp2016.serviciosExternos.cgp.CentroDTO
import edu.tp2016.serviciosExternos.cgp.InterfazCGP
import java.util.ArrayList
import java.util.List
import java.util.Arrays
import edu.tp2016.serviciosExternos.cgp.ServicioDTO
import edu.tp2016.serviciosExternos.cgp.RangoServicioDTO

class StubInterfazCGP implements InterfazCGP {

	override List<CentroDTO> buscar(String texto) {
		val lista = new ArrayList<CentroDTO>
		val centro1 = new CentroDTO() => [
			numeroComuna = 3
			zonasIncluidas = "Balvanera, San Cristobal"
			domicilio = "Junin 521"
			telefono = "4375-0644/45"
			servicios = Arrays.asList(
				new ServicioDTO() => [
					nombreServicio = "Atencion ciudadana"
					rangos = Arrays.asList(
						new RangoServicioDTO() => [
							numeroDia = 1
							horarioDesde = 9
							minutosDesde = 0
							horarioHasta = 18
							minutosHasta = 0
						]
					)
				]
			)
		]
		
		val centro2 = new CentroDTO() => [
			numeroComuna = 2
			zonasIncluidas = "Caballito, Almagro"
			domicilio = "Yatay 410"
			telefono = "4520-9635"
			servicios = Arrays.asList(
				new ServicioDTO() => [
					nombreServicio = "Rentas"
					rangos = Arrays.asList(
						new RangoServicioDTO() => [
							numeroDia = 1
							horarioDesde = 9
							minutosDesde = 0
							horarioHasta = 18
							minutosHasta = 0
						]
					)
				]
			)
		]

		lista.add(centro1)
		lista.add(centro2)
		lista
	}

}
