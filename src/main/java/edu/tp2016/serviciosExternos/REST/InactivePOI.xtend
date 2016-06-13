package edu.tp2016.serviciosExternos.REST

import com.eclipsesource.json.JsonObject
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Date

@Accessors
class InactivePOI extends JsonObject{

	int id
	Date fecha

} 