import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.ErrorsPanel

class TweetWindow extends MainWindow<Tweet> {



	new() {
		super(new Tweet)
	}

	def static main(String[] args) {
		new TweetWindow().startApplication
	}
	
	override createContents(Panel mainPanel) {
		
		new Label(mainPanel).text = "Tweetee Aquí:"
		new ErrorsPanel(mainPanel, "Ingrese hasta 140 caracteres.")
		
		new TextBox(mainPanel)=>[
			value <=> "textoEscrito"
			width = 210
			
			]
		
		new Label(mainPanel)=>[
			value <=> "caracteresRestantes"
		]
			
	}
	
}
