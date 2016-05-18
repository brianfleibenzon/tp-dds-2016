package edu.tp2016.serviciosExternos.banco

import java.util.List
import edu.tp2016.serviciosExternos.banco.SucursalBanco

/**
 * InterfazBanco es una interfaz externa que nos provee la búsqueda de bancos.
 * Dicha interfaz entiende el mensaje 'buscar', que recibe como parámetro un String con
 * el nombre de un Banco y de devuelve una lista de SucursalBanco (sucursales bancarias
 * que coinciden con el criterio de búsqueda).
 *
 * @param  nombreBanco  cadena de texto que representa el nombre de un banco
 * @return lista de sucursales bancarias

 */
interface ServicioExternoBanco {
	def List<SucursalBanco> buscar(String nombreBanco)
}