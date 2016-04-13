package edu.tp2016

import org.uqbar.geodds.Polygon
import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList

@Accessors
class Comuna {
	Polygon poligono
	int numero
	List<String> barrios = new ArrayList<String>
	
	def boolean pertenecePunto(Point unPunto){
		poligono.isInside(unPunto)
	}
}