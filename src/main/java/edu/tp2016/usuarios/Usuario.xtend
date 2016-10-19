package edu.tp2016.usuarios

import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.observersBusqueda.BusquedaObserver
import java.util.List
import edu.tp2016.pois.POI
import edu.tp2016.applicationModel.Buscador
import org.uqbar.commons.utils.Observable
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
import javax.persistence.CascadeType
import edu.tp2016.repositorio.RepoUsuarios

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
	
	@ManyToOne(cascade=CascadeType.ALL)
	Punto ubicacionActual
	
	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	Set<POI> poisFavoritos = new HashSet<POI>
	
	new(){ } // Constructor default de la superclase
	
	def adscribirObserver(BusquedaObserver observador){
		busquedaObservers.add(observador)
	}
	
	def quitarObserver(BusquedaObserver observador){
		busquedaObservers.remove(observador)
	}
	
	def registrarBusqueda(List<String> criterios, Set<POI> poisDevueltos, long demora, Buscador buscador){
		busquedaObservers.forEach [ observer |
			observer.registrarBusqueda(criterios, poisDevueltos, demora, this, buscador) ]
	}
	
	def tienePoiFavorito(POI poi){
		poisFavoritos.exists[it.id == poi.id]
	}
	
	def modificarPoiFavorito(POI poi, Boolean esFavorito){
		if(esFavorito){
			if (!tienePoiFavorito(poi)){
				poisFavoritos.add(poi)
			}			
		}else{
			if (tienePoiFavorito(poi)){
				poisFavoritos.removeIf[it.id == poi.id]
			}			
		}
	}

}