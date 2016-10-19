package edu.tp2016.procesos

import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.usuarios.Administrador
import org.joda.time.LocalDateTime
import edu.tp2016.applicationModel.Buscador
import javax.persistence.Entity
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.DiscriminatorColumn
import javax.persistence.DiscriminatorType
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Column
import javax.persistence.ManyToOne
import javax.persistence.CascadeType

@Entity
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="tipoProceso", 
   discriminatorType=DiscriminatorType.INTEGER)
@Accessors
abstract class Proceso implements Cloneable {
	@Id
	@GeneratedValue
	private Long id
	
	@ManyToOne(cascade=CascadeType.ALL)	
	Proceso accionEnCasoDeError = null

	@Column	
	int reintentos = 0
	
	@Column
	LocalDateTime inicio
	
	@Column
	LocalDateTime fin
	
	@ManyToOne(cascade=CascadeType.ALL)
	Administrador usuarioAdministrador
	
	@Column
	public static final boolean OK = true

	@Column
	public static final boolean ERROR = false
	
	@ManyToOne(cascade=CascadeType.ALL)
	Buscador buscador
	
	/**
	 * Llama a correr() adentro de un try catch.
	 * 
	 */
	def void iniciar(Administrador _usuarioAdministrador, Buscador _buscador){
		usuarioAdministrador = _usuarioAdministrador
		buscador = _buscador
		try{
			inicio = new LocalDateTime()
			this.correr()
			fin = new LocalDateTime()
			registrarExito(inicio, fin)
		}catch(Exception e){
			manejarError(e)
		}
	}
	
	/**
	 * Realiza la ejecución de un proceso. Esta función es privada, para ejecutar
	 * un proceso se debe llamar a iniciar()
	 * 
	 */
	def void correr(){}
	 
	def void manejarError(Exception e){
		if (reintentos == 0){
			if (accionEnCasoDeError != null){
				accionEnCasoDeError.iniciar(usuarioAdministrador, buscador);
			}
			fin = new LocalDateTime()
				registrarError(inicio, fin, e)
		}else{
			reintentos --
			this.iniciar(usuarioAdministrador, buscador)
		}		
	}
	
	def void registrarExito(LocalDateTime inicio, LocalDateTime fin){
		usuarioAdministrador.registrarResultado(new ResultadoDeProceso(inicio, fin, this, usuarioAdministrador, OK))
	}
	
	def void registrarError(LocalDateTime inicio, LocalDateTime fin, Exception e){
		usuarioAdministrador.registrarResultado(new ResultadoDeProceso(inicio, fin, this, usuarioAdministrador, ERROR, e.message))
	}
}