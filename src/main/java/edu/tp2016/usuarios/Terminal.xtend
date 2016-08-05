package edu.tp2016.usuarios

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Terminal extends Usuario {
		
	new(String nombre) {
		userName = nombre
	}
	
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