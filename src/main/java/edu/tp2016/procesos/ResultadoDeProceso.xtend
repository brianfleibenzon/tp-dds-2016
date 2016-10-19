package edu.tp2016.procesos

import org.joda.time.LocalDateTime
import edu.tp2016.usuarios.Administrador
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.DiscriminatorColumn
import javax.persistence.DiscriminatorType
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.ManyToOne
import javax.persistence.CascadeType
import javax.persistence.Column

@Entity
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="tipoObserver", 
   discriminatorType=DiscriminatorType.INTEGER)
@Accessors
class ResultadoDeProceso {
	@Id
	@GeneratedValue
	private Long id
	
	@Column
	LocalDateTime inicioEjecucion
	
	@Column
	LocalDateTime finEjecucion
	
	@ManyToOne(cascade=CascadeType.ALL)
	Proceso procesoEjecutado
	
	@ManyToOne(cascade=CascadeType.ALL)
	Administrador idUsuario
	
	@Column
	boolean resultadoEjecucion // OK o ERROR
	
	@Column(length=150)
	String mensajeDeError // opcional

	
	/**
	 * Construye el resultado de ejecución de un proceso incluyendo un mensaje de error.
	 * 
	 * @param
	 * @return resultado de la ejecución de un proceso con mensaje de error
	 */
	new(LocalDateTime inicio, LocalDateTime fin, Proceso proceso,
			Administrador usuario, boolean resultado, String error){
		inicioEjecucion = inicio
		finEjecucion = fin
		procesoEjecutado = proceso
		idUsuario = usuario
		resultadoEjecucion = resultado
		mensajeDeError = error
	}
	
	/**
	 * Construye el resultado de ejecución de un proceso sin incluir un mensaje de error.
	 * 
	 * @param inicio y fin de ejecución, proceso ejecutado, usuario que lo ejecutó, resultado
	 * @return resultado de la ejecución de un proceso
	 */
	new(LocalDateTime inicio, LocalDateTime fin, Proceso proceso,
			Administrador usuario, boolean resultado){
		inicioEjecucion = inicio
		finEjecucion = fin
		procesoEjecutado = proceso
		idUsuario = usuario
		resultadoEjecucion = resultado
	}
	
	
}