package serviciosExternos.REST

import java.util.List

interface ServicioExternoREST {
	def List<unPOI> buscar(String nombrePOI)
}