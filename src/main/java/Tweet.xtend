import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Tweet {
	int longitudMaxima=140
	int caracteresEscritos
		
	def int caracteresQueQuedan(String texto){
		
				
		caracteresEscritos=texto.length
		
		longitudMaxima-caracteresEscritos
		
		}
	
	
}
