package edu.tp2016

import org.junit.Before
import org.junit.Test
import org.junit.Assert
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon

class TestCercania {

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

	@Before
	def void setUp() {
		unDispositivo = new Dispositivo() => [
			ubicacionActual = new Point(-34.598574, -58.420280)
		]
		paradaCerca = new ParadaDeColectivo() => [
			nombre = "114"
			ubicacion = new Point(-34.597768, -58.419860)
		]
		paradaLejos = new ParadaDeColectivo() => [
			nombre = "107"
			ubicacion = new Point(-34.597859, -58.423351)
		]
		bancoCerca = new Banco() => [
			nombre = "Santander"
			ubicacion = new Point(-34.597768, -58.419860)
		]
		bancoLejos = new Banco() => [
			nombre = "Galicia"
			ubicacion = new Point(-34.594150, -58.416313)
		]
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
		CGPCerca = new CGP() => [
			nombre = "CGP Caballito"
			ubicacion = new Point(-34.597768, -58.419860)
			comuna = comunaInterior
		]
		CGPLejos = new CGP() => [
			nombre = "CGP Almagro"
			ubicacion = new Point(-34.594150, -58.416313)
			comuna = comunaExterior
		]
		rubroTest = new Rubro => [
			nombre = "indumentaria"
			radioDeCercania = 2
		]
		comercioCerca = new Comercio() => [
			nombre = "test"
			ubicacion = new Point(-34.597768, -58.419860)
			rubro = rubroTest
		]
		comercioLejos = new Comercio() => [
			nombre = "test"
			ubicacion = new Point(-34.597824, -58.423415)
			rubro = rubroTest
		]

	}

	@Test
	def void paradaEstaCerca() {
		Assert.assertEquals(true, unDispositivo.consultarCercania(paradaCerca))
	}

	@Test
	def void paradaEstaLejos() {
		Assert.assertEquals(false, unDispositivo.consultarCercania(paradaLejos))
	}

	@Test
	def void bancoEstaCerca() {
		Assert.assertEquals(true, unDispositivo.consultarCercania(bancoCerca))
	}

	@Test
	def void bancoEstaLejos() {
		Assert.assertEquals(false, unDispositivo.consultarCercania(bancoLejos))
	}

	@Test
	def void CGPEstaCerca() {
		Assert.assertEquals(true, unDispositivo.consultarCercania(CGPCerca))
	}

	@Test
	def void CGPEstaLejos() {
		Assert.assertEquals(false, unDispositivo.consultarCercania(CGPLejos))
	}

	@Test
	def void comercioEstaCerca() {
		Assert.assertEquals(true, unDispositivo.consultarCercania(comercioCerca))
	}

	@Test
	def void comercioEstaLejos() {
		Assert.assertEquals(false, unDispositivo.consultarCercania(comercioLejos))
	}

}
