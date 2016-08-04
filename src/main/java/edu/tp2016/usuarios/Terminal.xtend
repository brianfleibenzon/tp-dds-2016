package edu.tp2016.usuarios

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Terminal extends Usuario {
	
	 def clonar(){
	    return new Terminal(userName)
    }
    
    def copyFrom(Terminal usuarioBefore){
		busquedaObservers.clear
		busquedaObservers.addAll(usuarioBefore.busquedaObservers)
    }

}