package edu.tp2016.repositorio

import edu.tp2016.usuarios.Usuario
import java.util.ArrayList
import edu.tp2016.usuarios.Terminal
import edu.tp2016.usuarios.Administrador
import com.google.common.collect.Lists
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions

class RepoUsuarios extends RepoDefault<Usuario>{
	private static RepoUsuarios instance = null

	override def getEntityType() {
		typeof(Usuario)
	}
	
	def agregarUsuario(Usuario usuario){
		this.create(usuario)
	}
	
	static def getInstance() {
		if (instance == null) {
			instance = new RepoUsuarios
		}
		instance
	}
	

	def agregarVariosUsuarios(ArrayList<Terminal> usuarios){
		usuarios.forEach [ usuario | this.agregarUsuario(usuario)]
	}
	
	
	def Usuario buscar(String username, String clave) {
	    allInstances.findFirst [it.userName.equals(username) && 
	        it.password.equals(clave)]
	}
	
	override addQueryByExample(Criteria criteria, Usuario usuario) {
		if (usuario.userName != null) {
			criteria.add(Restrictions.eq("userName", usuario.userName))
		}
	}
	
}