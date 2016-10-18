package edu.tp2016.pois

import edu.tp2016.mod.DiaDeAtencion
import edu.tp2016.mod.Review
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import org.uqbar.geodds.Point
import org.uqbar.commons.utils.Observable
import edu.tp2016.mod.Servicio
import org.apache.commons.lang.StringUtils
import edu.tp2016.usuarios.Usuario
import javax.persistence.Entity
import javax.persistence.Column
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.OneToMany
import javax.persistence.ElementCollection
import javax.persistence.CollectionTable
import javax.persistence.JoinColumn
import javax.persistence.ManyToOne
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.DiscriminatorColumn
import javax.persistence.DiscriminatorType
import edu.tp2016.mod.Punto
import javax.persistence.FetchType
import javax.persistence.CascadeType
import java.util.HashSet
import java.util.Set

@Entity
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="tipoPoi", 
   discriminatorType=DiscriminatorType.INTEGER)
@Observable
@Accessors
class POI implements Cloneable {
	@Id
	@GeneratedValue
	private Long id
	
	@Column(length=100)
	String nombre
	
	@Column(length=100)
	String direccion	

	@ManyToOne(cascade=CascadeType.ALL)
	Punto ubicacion
	
	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	List<DiaDeAtencion> rangoDeAtencion = new ArrayList<DiaDeAtencion>
	
	@ElementCollection(fetch=FetchType.EAGER)
	@CollectionTable(name="PalabrasClave", joinColumns=@JoinColumn(name="clave_id"))
	@Column(name="palabrasClave")
	List<String> palabrasClave = new ArrayList<String>
	
	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	Set<Review> reviews = new HashSet<Review>
	
	@ManyToOne()
	Servicio servicioSeleccionado	
	
	@Column(length=100)
	String comentario
	
	@Column()
	int calificacion
	
	@Column()
	boolean favorito
	
	@Column()
	float calificacionGeneral
	
	@ManyToOne()
	Usuario usuario

	/**
	 * Constructor de POI, será redefinido en las subclases, por lo que hay que llamar a 'super'
	 * 
	 * @param unNombre nombre del POI
	 * @param unaUbicacion la ubicacion del POI en formato Point(x, y)
	 * @param claves lista de strings con etiquetas
	 */
	new(String unNombre, Point unaUbicacion, List<String> claves) {
		nombre = unNombre
		ubicacion = new Punto(unaUbicacion.latitude, unaUbicacion.longitude)
		palabrasClave = claves
	}
	
	new(){ } // default
	
	def copy() {
		super.clone as POI
	}

	def boolean estaDisponible(LocalDateTime unaFecha, String nombre){
		false // by default
	}

	def boolean tieneRangoDeAtencionDisponibleEn(LocalDateTime fecha) {
		rangoDeAtencion.exists [unRango | unRango.fechaEstaEnRango(fecha)]
	}

	def boolean estaCercaA(Punto ubicacionDispositivo) {
		distanciaA(ubicacionDispositivo) < 5
	}

	def double distanciaA(Punto unPunto) {
		val ubi = new Point(ubicacion.x, ubicacion.y)
		val punto = new Point(unPunto.x, unPunto.y)
		punto.distance(ubi) * 10
	}

	/**
	 * Busca el texto en las palabras claves del POI
	 * La búsqueda por palabra clave es igual para todos los POI.
	 * 
	 * @param texto cadena de busqueda
	 * @return valor de verdad si se encuentra el texto en alguna palabra clave
	 */
	def boolean tienePalabraClave(String texto) {
		palabrasClave.contains(texto)
	}

	/**
	 * Busca el texto en el nombre del POI
	 * 
	 * @param texto cadena de busqueda
	 * @return valor de verdad si el nombre coincide con el texto
	 */
	def boolean coincide(String texto) {
		StringUtils.containsIgnoreCase(nombre, texto)
	}
	
	def void agregarPalabraClave(String unaPalabra){
		palabrasClave.add(unaPalabra)
	}
	
	def inicializarDatos(){
		calificacionGeneral = 0
		calificacion = 1
		comentario = ""
		
		favorito = usuario.tienePoiFavorito(this)
		reviews.forEach [
			calificacionGeneral += it.calificacion
			if (it.usuario.id == usuario.id){
				calificacion = it.calificacion
				comentario = it.comentario
			}
		]
		calificacionGeneral = calificacionGeneral / reviews.size
	}
	
	def inicializar(Usuario usuarioActivo){
		usuario = usuarioActivo
		inicializarDatos
	}
	
	def getCalificacionGeneral(){		
		"Calificacion general: " + calificacionGeneral
	}
	
	def guardarCalificacion(){
		val review = reviews.findFirst [
			it.usuario == usuario
		]
		if (review == null){
			reviews.add(new Review(calificacion, usuario, comentario))
		}else{
			review.calificacion = calificacion
			review.comentario = comentario
		}
		inicializarDatos
	}
	
	def void setFavorito(boolean valor){
		favorito = valor
		if(usuario != null){
			usuario.modificarPoiFavorito(this, valor)
		}
	}
	
	def String getFavoritoStatus(){
		if(favorito) "     ✓" else ""
	}
	
	def String getCercania(){
		if(estaCercaA(usuario.ubicacionActual)) "Sí" else "No"
	}
	
	def String getDistancia(){
		String.format("%.2f", distanciaA(usuario.ubicacionActual)/10) + ' km'
	}
	
	def limpiarReviewInputs(){
		comentario = ""
		calificacion = 1
	}
}
