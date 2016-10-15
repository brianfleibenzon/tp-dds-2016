package edu.tp2016.observersBusqueda

import java.util.List
import edu.tp2016.pois.POI
import edu.tp2016.usuarios.Usuario
import edu.tp2016.applicationModel.Buscador
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.InheritanceType
import javax.persistence.DiscriminatorType
import javax.persistence.Inheritance
import javax.persistence.DiscriminatorColumn

@Entity
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="tipoObserver", 
   discriminatorType=DiscriminatorType.INTEGER)
abstract class BusquedaObserver {	
	@Id
	@GeneratedValue
	private Long id
	
	def void registrarBusqueda(List<String> criterios, List<POI> poisDevueltos, long demora,
		Usuario usuario, Buscador buscador)
		
}
