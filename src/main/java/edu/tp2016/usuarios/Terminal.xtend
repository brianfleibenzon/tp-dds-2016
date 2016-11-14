package edu.tp2016.usuarios

import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.observersBusqueda.BusquedaObserver
import java.util.List
import javax.persistence.DiscriminatorValue
import javax.persistence.Entity

@Accessors
@Entity
@DiscriminatorValue("1")
class Terminal extends Usuario {
	
	new(){}
		
	new(String nombre) {
		userName = nombre
	}
	
	new(String nombre, String contraseña) {
		userName = nombre
		password = contraseña
	} // Constructor para el Login
	
	new(List<BusquedaObserver> observers){
		busquedaObservers.clear
		busquedaObservers.addAll(observers)
	} // Constructor para la clonación
	
	def clonar(){
	    return new Terminal(userName) => [
	    	busquedaObservers.addAll(this.busquedaObservers)
	    ]
    }
    
    def copyFrom(Terminal usuarioBefore){
		busquedaObservers.clear
		busquedaObservers.addAll(usuarioBefore.busquedaObservers)
    }

}