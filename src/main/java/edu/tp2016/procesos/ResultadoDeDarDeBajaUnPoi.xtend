package edu.tp2016.procesos


import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Date

class ResultadoDeDarDeBajaUnPoi {

@Accessors
Date fechaDeBaja
int ID

new (Date fecha, int PoiID){
	fechaDeBaja = fecha
	ID= PoiID
}

	
}