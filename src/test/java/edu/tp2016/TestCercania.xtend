package edu.tp2016

import edu.tp2016.mod.Comuna
import edu.tp2016.mod.DiaDeAtencion
import edu.tp2016.mod.Rubro
import edu.tp2016.mod.Servicio
import edu.tp2016.pois.Banco
import edu.tp2016.pois.CGP
import edu.tp2016.pois.Comercio
import edu.tp2016.pois.POI
import edu.tp2016.pois.ParadaDeColectivo
import java.util.Arrays
import java.util.List
import org.joda.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon
import edu.tp2016.servidores.ServidorLocal
import edu.tp2016.servidores.ServidorCentral
import builder.ParadaBuilder
import builder.BancoBuilder
import builder.CGPBuilder
import builder.ComercioBuilder

class TestCercania {

	ServidorLocal unServidorLocal
	ServidorCentral servidorCentral
	ParadaDeColectivo paradaCerca
	ParadaDeColectivo paradaLejos
	Banco bancoCerca
	Banco bancoLejos
	CGP CGPCerca
	CGP CGPLejos
	Comuna comunaInterior
	Comuna comunaExterior
	Rubro rubroTest
	Comercio comercioCerca
	Comercio comercioLejos
	DiaDeAtencion unDiaX
	List<DiaDeAtencion> rangoX
	LocalDateTime fechaX
	List<String> clavesX
	List<POI> poisX
	List<Servicio> serviciosX

	@Before
	def void setUp() {

		rangoX = Arrays.asList(unDiaX)
		fechaX = new LocalDateTime()
		clavesX = Arrays.asList("algunas", "palabras", "clave")

		serviciosX = Arrays.asList(new Servicio("x", rangoX))

		paradaCerca = new ParadaBuilder().nombre("114").
		ubicacion(new Point(-34.597768, -58.419860)).
		claves(clavesX).
		build

		paradaLejos = new ParadaBuilder().nombre("107").
		 ubicacion(new Point(-34.597859, -58.423351)).
		 claves(clavesX).
		 build

		bancoCerca = new BancoBuilder().nombre("Santander").
		ubicacion(new Point(-34.597768, -58.419860)).
		claves(clavesX).
		sucursal("Caballito").
		nombreGerente("Juan Perez").
		setearHorarios.
		build

		bancoLejos = new BancoBuilder().nombre("Galicia").
		ubicacion(new Point(-34.594150, -58.416313)).
		claves( clavesX).
		sucursal( "Belgrano").
		nombreGerente("María García").
		setearHorarios.
		build

		comunaInterior = new Comuna => [
			poligono = new Polygon()
			poligono.add(new Point(-34.597735, -58.421806))
			poligono.add(new Point(-34.597771, -58.417300))
			poligono.add(new Point(-34.600703, -58.420583))
			poligono.add(new Point(-34.601497, -58.416227))
		]
		comunaExterior = new Comuna => [
			poligono = new Polygon()
			poligono.add(new Point(-34.597735, -58.421806))
			poligono.add(new Point(-34.597771, -58.417300))
			poligono.add(new Point(-34.594238, -58.419617))
			poligono.add(new Point(-34.594167, -58.416334))
		]

		CGPCerca = new CGPBuilder().nombre("CGP Caballito").
		ubicacion(new Point(-34.597768, -58.419860)).
		claves(clavesX).
		 comuna(comunaInterior).
		 servicio(serviciosX).
		 zonasIncluidas( "").
		 nombreDirector("").
		 telefono("").
		 build

		CGPLejos = new CGPBuilder().nombre("CGP Almagro").
		ubicacion(new Point(-34.594150, -58.416313)).
		claves( clavesX).
		comuna(comunaExterior).
		servicio(serviciosX).
	    zonasIncluidas("").
	    nombreDirector("").
	    telefono("").
	    build

		rubroTest = new Rubro("indumentaria", 2)

		comercioCerca = new ComercioBuilder().nombre("test").
		ubicacion(new Point(-34.597768, -58.419860)).
		claves(clavesX).
		rubro(rubroTest).
		rango(rangoX).
        build
        
		comercioLejos = new ComercioBuilder().nombre("test").
		ubicacion(new Point(-34.597824, -58.423415)).
		claves(clavesX).
		rubro(rubroTest).
		rango(rangoX).
		build

		poisX = Arrays.asList(bancoCerca, bancoLejos, CGPCerca, CGPLejos, comercioCerca, comercioLejos, paradaCerca,
			paradaLejos)
		servidorCentral = new ServidorCentral(poisX)
		unServidorLocal = new ServidorLocal(new Point(-34.598574, -58.420280), "unServidorLocal", servidorCentral)

	}

	@Test
	def void paradaEstaCerca() {
		Assert.assertTrue(unServidorLocal.consultarCercania(paradaCerca))
	}

	@Test
	def void paradaEstaLejos() {
		Assert.assertFalse(unServidorLocal.consultarCercania(paradaLejos))
	}

	@Test
	def void bancoEstaCerca() {
		Assert.assertTrue(unServidorLocal.consultarCercania(bancoCerca))
	}

	@Test
	def void bancoEstaLejos() {
		Assert.assertFalse(unServidorLocal.consultarCercania(bancoLejos))
	}

	@Test
	def void CGPEstaCerca() {
		Assert.assertTrue(unServidorLocal.consultarCercania(CGPCerca))
	}

	@Test
	def void CGPEstaLejos() {
		Assert.assertFalse(unServidorLocal.consultarCercania(CGPLejos))
	}

	@Test
	def void comercioEstaCerca() {
		Assert.assertTrue(unServidorLocal.consultarCercania(comercioCerca))
	}

	@Test
	def void comercioEstaLejos() {
		Assert.assertFalse(unServidorLocal.consultarCercania(comercioLejos))
	}

}
