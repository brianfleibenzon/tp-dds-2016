import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.TextBox

class TweetWindow extends MainWindow<Tweet> {



	new() {
		super(new Tweet)
	}

	def static main(String[] args) {
		new TweetWindow().startApplication
	}
	
	override createContents(Panel mainPanel) {
		val panel1= new Panel(mainPanel)
		new Label(panel1).text = "Tweetee Aquí:"
		
		new TextBox(panel1)=>[
			value <=> "textoEscrito"
			width = 210
			]
		
		new Label(mainPanel)=>[
			value <=> "caracteresQueQuedan"
			
		]
			
	}
	
}
