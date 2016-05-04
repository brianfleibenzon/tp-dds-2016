package edu.tp2016

import com.google.common.collect.Lists
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

class TestCercania{

	Dispositivo unDispositivo
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

		rangoX = Arrays.asList(Lists.newArrayList(unDiaX))
		fechaX = new LocalDateTime()
		clavesX = Arrays.asList(Lists.newArrayList("algunas", "palabras", "clave"))
		poisX = Arrays.asList(
			Lists.newArrayList(bancoCerca, bancoLejos, CGPCerca, CGPLejos, comercioCerca, comercioLejos, paradaCerca,
				paradaLejos))
		serviciosX = Arrays.asList(Lists.newArrayList(new Servicio("x", rangoX)))

		unDispositivo = new Dispositivo(new Point(-34.598574, -58.420280), poisX, fechaX)

		paradaCerca = new ParadaDeColectivo("114", new Point(-34.597768, -58.419860), clavesX)

		paradaLejos = new ParadaDeColectivo("107", new Point(-34.597859, -58.423351), clavesX)

		bancoCerca = new Banco("Santander", new Point(-34.597768, -58.419860), clavesX,"Caballito", "Juan Perez")

		bancoLejos = new Banco("Galicia", new Point(-34.594150, -58.416313), clavesX, "Belgrano", "María García")

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

		CGPCerca = new CGP("CGP Caballito", new Point(-34.597768, -58.419860), clavesX, comunaInterior, serviciosX, "",
			"", "")

		CGPLejos = new CGP("CGP Almagro", new Point(-34.594150, -58.416313), clavesX, comunaExterior, serviciosX, "",
			"", "")

		rubroTest = new Rubro("indumentaria", 2)

		comercioCerca = new Comercio("test", new Point(-34.597768, -58.419860), clavesX, rubroTest, rangoX)

		comercioLejos = new Comercio("test", new Point(-34.597824, -58.423415), clavesX, rubroTest, rangoX)
	}

	@Test
	def void paradaEstaCerca() {
		Assert.assertTrue(unDispositivo.consultarCercania(paradaCerca))
	}

	@Test
	def void paradaEstaLejos() {
		Assert.assertFalse(unDispositivo.consultarCercania(paradaLejos))
	}

	@Test
	def void bancoEstaCerca() {
		Assert.assertTrue(unDispositivo.consultarCercania(bancoCerca))
	}

	@Test
	def void bancoEstaLejos() {
		Assert.assertFalse(unDispositivo.consultarCercania(bancoLejos))
	}

	@Test
	def void CGPEstaCerca() {
		Assert.assertTrue(unDispositivo.consultarCercania(CGPCerca))
	}

	@Test
	def void CGPEstaLejos() {
		Assert.assertFalse(unDispositivo.consultarCercania(CGPLejos))
	}

	@Test
	def void comercioEstaCerca() {
		Assert.assertTrue(unDispositivo.consultarCercania(comercioCerca))
	}

	@Test
	def void comercioEstaLejos() {
		Assert.assertFalse(unDispositivo.consultarCercania(comercioLejos))
	}

}
