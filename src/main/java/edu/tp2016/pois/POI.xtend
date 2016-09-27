package edu.tp2016.pois

import edu.tp2016.mod.DiaDeAtencion
import edu.tp2016.mod.Review
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import org.uqbar.geodds.Point
import org.uqbar.commons.model.Entity
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.UserException
import edu.tp2016.mod.Servicio
import org.apache.commons.lang.StringUtils
import edu.tp2016.usuarios.Usuario

@Observable
@Accessors
class POI extends Entity implements Cloneable {
	String nombre
	String direccion
	Point ubicacion
	List<DiaDeAtencion> rangoDeAtencion = new ArrayList<DiaDeAtencion>
	List<String> palabrasClave = new ArrayList<String>
	List<Review> reviews = new ArrayList<Review>
	Servicio servicioSeleccionado
	String comentario
	int calificacion
	boolean favorito
	String cercania
	String distancia
	String favoritoStatus
	float calificacionGeneral
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
		ubicacion = unaUbicacion
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

	def boolean estaCercaA(Point ubicacionDispositivo) {
		distanciaA(ubicacionDispositivo) < 5
	}

	def double distanciaA(Point unPunto) {
		unPunto.distance(ubicacion) * 10
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
		favoritoStatus = if(favorito) "     ✓" else ""
	}
	
	def getCercania(){
		cercania = if(this.estaCercaA(usuario.ubicacionActual)) "SI" else "NO"
	}
	
	def getDistancia(){
		distancia = String.format("%.2f", distanciaA(usuario.ubicacionActual)/10) + ' km'
	}
}
