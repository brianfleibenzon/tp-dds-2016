package edu.tp2016.observersBusqueda

import org.joda.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList
import javax.persistence.Entity
import javax.persistence.Column
import javax.persistence.ElementCollection
import javax.persistence.CollectionTable
import javax.persistence.JoinColumn
import javax.persistence.GeneratedValue
import javax.persistence.Id

@Entity
@ Accessors
class Busqueda{
	@Id
	@GeneratedValue
	private Long id
	
	@Column()
	LocalDateTime fecha
	
	@Column(length=100)
	String nombreUsuario
	
	@Column()
	int cantidadDeResultados
	
	@Column()
	long demoraConsulta
	
	@ElementCollection
	@CollectionTable(name="PalabrasBuscadas", joinColumns=@JoinColumn(name="palabras_id"))
	@Column(name="palabrasBuscadas")
	List<String> palabrasBuscadas = new ArrayList<String>
}
