package edu.tp2016.application

import edu.tp2016.builder.BancoBuilder
import edu.tp2016.builder.CGPBuilder
import edu.tp2016.builder.ComercioBuilder
import edu.tp2016.builder.ParadaBuilder
import edu.tp2016.mod.Comuna
import edu.tp2016.mod.DiaDeAtencion
import edu.tp2016.mod.Punto
import edu.tp2016.mod.Rubro
import edu.tp2016.mod.Servicio
import edu.tp2016.pois.POI
import edu.tp2016.repositorio.RepoPois
import edu.tp2016.repositorio.RepoUsuarios
import edu.tp2016.usuarios.Terminal
import edu.tp2016.usuarios.Usuario
import java.util.Arrays
import com.google.common.collect.Lists
import org.uqbar.arena.bootstrap.Bootstrap

class PoisBootstrap implements Bootstrap {
	
	def initUsuarios(){
		this.crearUsuario(new Terminal("juanPerez", "1234"))
		this.crearUsuario(new Terminal("usr", "usr"))
		//this.crearUsuario(new Administrador("admin", "admin"))
	}
	
	def crearUsuario(Usuario usr){
		val repoUsuarios = RepoUsuarios.instance
		val listaUsuarios = repoUsuarios.searchByExample(usr)
		if (listaUsuarios.isEmpty) {
			repoUsuarios.create(usr)
		} else {
			/*val usuarioBD = listaUsuarios.head
			usr.id = usuarioBD.id
			repoUsuarios.update(usr)*/
		}
	}
	
	
	def initPois(){
		val ubicacionParadasUTN= new Punto(-34.659705, -58.468103)
		
		val utn7parada = new ParadaBuilder().nombre("7_utn").lineaColectivo("7").
		ubicacion(ubicacionParadasUTN).direccion("Mozart 2300").
		claves( Arrays.asList("utn", "campus", "colectivo", "parada")).build
		
		val ubicacionColectivoOnce=new Punto(-34.653570, -58.549873)
		val miserere7parada = new ParadaBuilder().nombre("7_once").lineaColectivo("7").
		ubicacion(ubicacionColectivoOnce).direccion("Pueyrredón 1600").
		claves(Arrays.asList("plaza miserere", "once", "colectivo", "parada")).build

		val utn114parada = new ParadaBuilder().nombre("114_utn").lineaColectivo("114").
		ubicacion(ubicacionParadasUTN).direccion("Mozart 2300").
		claves(Arrays.asList("utn", "campus", "colectivo", "parada")).build

		val rubroFarmacia = new Rubro("Farmacia", 1)
		val rubroLibreria = new Rubro("Libreria", 2)
	
		val ubicacionFarmacity=new Punto(-34.600319, -58.437463)
	    val comercioFarmacity = new ComercioBuilder().nombre("Farmacity").direccion("Corrientes 5081").
		ubicacion(ubicacionFarmacity).
		claves(Arrays.asList("comercio","medicamentos", "salud", "farmacia")).
		rubro(rubroFarmacia).
		rango(Arrays.asList(new DiaDeAtencion(2,10,19,0,0), new DiaDeAtencion(3,10,19,0,0))).build

		val ubicacionLoDeJuan=new Punto(-34.600171, -58.420530)
		val comercioLoDeJuan = new ComercioBuilder().nombre("Libreria Juan").direccion("Medrano 850").
		ubicacion(ubicacionLoDeJuan).
		claves(Arrays.asList("comercio","fotocopias", "utiles", "libros")).
		rubro(rubroLibreria).
		rango(Arrays.asList(new DiaDeAtencion(2,10,19,0,0), new DiaDeAtencion(3,10,19,0,0))).build
		
		val cultura = new Servicio("Cultura", Lists.newArrayList(new DiaDeAtencion(2,8,16,0,0)))
		val deportes = new Servicio("Deportes", Lists.newArrayList(
			new DiaDeAtencion(2,10,12,0,0), new DiaDeAtencion(4,14,19,30,0),new DiaDeAtencion(6,15,20,30,0)))
        val asesoramientoLegal = new Servicio("Asesoramiento legal", Arrays.asList(new DiaDeAtencion(2,10,19,0,0), new DiaDeAtencion(3,10,19,0,0)))
	 
	    val comunaX = new Comuna => [
			poligono.add(new Punto(-1, 1))
			poligono.add(new Punto(-2, 2))
			poligono.add(new Punto(-3, 3))
			poligono.add(new Punto(-4, 4))
		]
	
		val ubicacionCGPComuna1 = new Punto(-34.608365, -58.370973)
	    val CGPComuna1 = new CGPBuilder().nombre("CGP Comuna 1").
	    	ubicacion(ubicacionCGPComuna1).direccion("Balcarce 52").zonasIncluidas("Puerto Madero-Retiro-San Nicolás").claves(
			Arrays.asList("CGP", "centro de atención", "servicios sociales", "comuna 1")).comuna(comunaX).servicio(
			Arrays.asList(asesoramientoLegal, cultura, deportes)).nombreDirector("").telefono("").build
			
		val ubicacionBancoPatagonia=new Punto (-34.657996, -58.471178)
		val BancoPatagonia = new BancoBuilder().nombre("Banco Patagonia").ubicacion(ubicacionBancoPatagonia).direccion("Mozart 2100").claves(
			Arrays.asList("Cobro cheques", "Cajero automático", "Seguros", "Créditos", "Depósitos","Extracciones")).nombreGerente("Armando Lopez").
			sucursal("Lugano").setearHorarios().build
	
		this.crearPoi(utn7parada)
		this.crearPoi(utn114parada)
		this.crearPoi(miserere7parada)
		this.crearPoi(comercioFarmacity)
		this.crearPoi(comercioLoDeJuan)
		this.crearPoi(CGPComuna1)
		this.crearPoi(BancoPatagonia)

	}
	
	def crearPoi(POI poi){
		val repoPois = RepoPois.instance
		val busquedaPoi = repoPois.searchByExample(poi)
		if (busquedaPoi.isEmpty) {
			//poi.isActive = true // TODO
			repoPois.create(poi)
		} else {
			/*val poiBD = listaPois.head
			poi.id = poiBD.id
			repoPois.update(poi)*/
		}
	}
	
	override run() {
		initUsuarios
		initPois
	}
	
	override isPending() {
		false
	}
	
	
}