package edu.tp2016.procesos

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime

class ResultadoDeDarDeBajaUnPoi {

	@Accessors
	LocalDateTime fechaDeBaja
	int ID

	new(LocalDateTime fecha, int PoiID) {
		fechaDeBaja = fecha
		ID = PoiID
	}

}
