package edu.tp2016
import org.junit.Before
import org.junit.Test
import org.junit.Assert

class TestDisponibilidad {
	Dispositivo unDispositivo
	Dispositivo unDispositivoConFechaNoDisponibleParaBanco
	FechaCompleta fechaCualquiera
	FechaCompleta fechaNoDisponibleParaBanco
	ParadaDeColectivo unaParada
	Banco unBanco
	
	DiaDeAtencion lunes
	DiaDeAtencion martes
	DiaDeAtencion miercoles
	DiaDeAtencion jueves
	DiaDeAtencion viernes
	
	
	@Before
	def void SetUp(){
	unaParada = new ParadaDeColectivo()=> [
						
					]
	fechaCualquiera= new FechaCompleta()=> [
				hora=11
				minutos=20
				segundos=45
				//VAMOS A TOMAR DIA 1=LUNES
				dia=1
	 			mes=2
	 			anio=2016						
					]
	fechaNoDisponibleParaBanco= new FechaCompleta()=> [
				hora=11
				minutos=20
				segundos=45
				//VAMOS A TOMAR DIA 1=LUNES
				dia=7
	 			mes=2
	 			anio=2016						
					]
	unDispositivo = new Dispositivo()=> [
			fechaActual= fechaCualquiera
		]
	unDispositivoConFechaNoDisponibleParaBanco = new Dispositivo()=> [
			fechaActual= fechaNoDisponibleParaBanco
		]
	
	lunes = new DiaDeAtencion()=> [
		dia=1
		horaInicio=10
		horaFin=15
					]
	martes = new DiaDeAtencion()=> [
		dia=2
		horaInicio=10
		horaFin=15
					]
	miercoles = new DiaDeAtencion()=> [
		dia=3
		horaInicio=10
		horaFin=15
					]
	jueves = new DiaDeAtencion()=> [
		dia=4
		horaInicio=10
		horaFin=15
					]
	viernes = new DiaDeAtencion()=> [
		dia=5
		horaInicio=10
		horaFin=15
					]
	unBanco = new Banco()=> [
				rangoDeAtencion.add(lunes)
				rangoDeAtencion.add(martes)
				rangoDeAtencion.add(miercoles)
				rangoDeAtencion.add(jueves)
				rangoDeAtencion.add(viernes)
								
					]
					}
					
@Test
def void ParadaDeColectivoEstaDisponible() {
		Assert.assertEquals(true, unDispositivo.consultarDisponibilidad(unaParada, ""))
	}

@Test
def void BancoEstaDisponible() {
		Assert.assertEquals(true, unDispositivo.consultarDisponibilidad(unBanco, ""))
	}
@Test	
def void BancoNoEstaDisponible() {
		Assert.assertEquals(false, unDispositivoConFechaNoDisponibleParaBanco.consultarDisponibilidad(unBanco, ""))
	}

}