package edu.tp2016.repositorio

import org.uqbar.commons.model.CollectionBasedRepo
import edu.tp2016.usuarios.Usuario
import java.util.Random
import org.apache.commons.collections15.Predicate
import java.util.ArrayList

class RepoUsuarios extends CollectionBasedRepo<Usuario>{
	private static RepoUsuarios instance = null
	Random rand = new Random()

	override createExample() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override def getEntityType() {
		typeof(Usuario)
	}
	
	def agregarUsuario(Usuario usuario){
		var nuevoId = rand.nextInt(1000) // le asigna un id aleatorio entre 0 y 999
			while(idEnUso(nuevoId)){
				nuevoId = rand.nextInt(1000)
			}
		usuario.id = nuevoId
		
		this.create(usuario)
	}
	
	def idEnUso(int id){
		!((objects.filter [ usuario | usuario.id.equals(id)]).isEmpty)
	}
	
	static def getInstance() {
		if (instance == null) {
			instance = new RepoUsuarios
		}
		instance
	}
	
	override def Predicate<Usuario> getCriterio(Usuario unUsuario) {
		var result = this.criterioTodas
		result
	}
	
	override getCriterioTodas() {
		[Usuario usuario|true] as Predicate<Usuario>
	}
	
	def agregarVariosUsuarios(ArrayList<Usuario> usuarios){
		usuarios.forEach [ usuario | this.agregarUsuario(usuario)]
	}
	
	
	def Usuario buscar(String username, String clave) {
	    allInstances.findFirst [it.userName.equals(username) && 
	        it.password.equals(clave)]
	}
	
	
}