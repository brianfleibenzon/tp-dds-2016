package edu.tp2016.usuarios

import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.serviciosExternos.MailSender
import edu.tp2016.observersBusqueda.BusquedaObserver
import java.util.List
import java.util.ArrayList

@Accessors
abstract class Usuario implements Cloneable {
	String userName
	String password
	MailSender mailSender
	String mailAdress
	List<BusquedaObserver> busquedaObservers = new ArrayList<BusquedaObserver>
	
	/**
	 * Construyo una Usuario con su nombre.
	 * 
	 * @param
	 * @return un usuario
	 */
	new(String nombre) {
		userName = nombre
	}
	
	new(List<BusquedaObserver> observers){
		busquedaObservers.clear
		busquedaObservers.addAll(observers)
	} // Constructor para la clonación
	
	def adscribirObserver(BusquedaObserver observador){
		busquedaObservers.add(observador)
	}
	
	def quitarObserver(BusquedaObserver observador){
		busquedaObservers.remove(observador)
	}
	
	def login(String name, String pass){
		userName = name
		password = pass
	}
}