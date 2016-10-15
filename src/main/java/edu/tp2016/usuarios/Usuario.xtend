package edu.tp2016.usuarios

import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.observersBusqueda.BusquedaObserver
import java.util.List
import java.util.ArrayList
import edu.tp2016.pois.POI
import edu.tp2016.applicationModel.Buscador
import org.uqbar.commons.utils.Observable
import org.uqbar.geodds.Point
import java.util.HashSet
import java.util.Set
import javax.persistence.Entity
import javax.persistence.Column
import javax.persistence.OneToMany
import javax.persistence.Id
import javax.persistence.GeneratedValue
import edu.tp2016.mod.Punto
import javax.persistence.InheritanceType
import javax.persistence.DiscriminatorColumn
import javax.persistence.Inheritance
import javax.persistence.DiscriminatorType
import javax.persistence.ManyToOne
import javax.persistence.FetchType

@Entity
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="tipoUsuario", 
   discriminatorType=DiscriminatorType.INTEGER)
@Observable
@Accessors
abstract class Usuario implements Cloneable {
	@Id
	@GeneratedValue
	private Long id
	
	@Column(length=100)
	String userName
	
	@Column(length=100)
	String password
	
	@Column(length=100)
	String mailAdress
	
	@OneToMany(fetch=FetchType.EAGER)
	Set<BusquedaObserver> busquedaObservers = new HashSet<BusquedaObserver>
	
	@ManyToOne()
	public Punto ubicacionActual
	
	@OneToMany(fetch=FetchType.EAGER)
	Set<POI> poisFavoritos = new HashSet<POI>
	
	new(){ } // Constructor default de la superclase
	
	def adscribirObserver(BusquedaObserver observador){
		busquedaObservers.add(observador)
	}
	
	def quitarObserver(BusquedaObserver observador){
		busquedaObservers.remove(observador)
	}
	
	def registrarBusqueda(List<String> criterios, List<POI> poisDevueltos, long demora, Buscador buscador){
		busquedaObservers.forEach [ observer |
			observer.registrarBusqueda(criterios, poisDevueltos, demora, this, buscador) ]
	}
	
	def tienePoiFavorito(POI poi){
		poisFavoritos.contains(poi)
	}
	
	def modificarPoiFavorito(POI poi, Boolean esFavorito){
		if (esFavorito){
			poisFavoritos.add(poi)
		}else{
			poisFavoritos.remove(poi)
		}
	}

}