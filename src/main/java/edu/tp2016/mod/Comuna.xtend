package edu.tp2016.mod

import org.uqbar.geodds.Polygon
import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList
import javax.persistence.Entity
import javax.persistence.Column
import javax.persistence.Id
import javax.persistence.ElementCollection
import javax.persistence.CollectionTable
import javax.persistence.JoinColumn
import javax.persistence.GeneratedValue
import javax.persistence.FetchType
import javax.persistence.CascadeType
import javax.persistence.OneToMany
import java.util.Set
import java.util.HashSet

@Entity
@Accessors
class Comuna {	
	@Id
	@GeneratedValue
	private Long id
	
	@Column
	int numero
	
	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	Set<Punto> poligono = new HashSet<Punto>
	
	@ElementCollection
	@CollectionTable(name="Barrios", joinColumns=@JoinColumn(name="barrio_id"))
	@Column(name="barrios")
	List<String> barrios = new ArrayList<String>
	
	/* new(Polygon unPoligono, List<String> listaBarrios) {
        poligono = unPoligono
        barrios = listaBarrios 
    }*/ //Por ahora no implementamos el constructor de Comuna
	
	
	def boolean pertenecePunto(Punto unPunto){
		val polig = new Polygon()
		poligono.forEach[polig.add(new Point(it.x, it.y))]
		
		polig.isInside(new Point(unPunto.x, unPunto.y))
	}
}
