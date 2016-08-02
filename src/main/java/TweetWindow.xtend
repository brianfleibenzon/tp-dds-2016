import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.NumericField
//import org.uqbar.arena.widgets.Button
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import java.awt.Color
import org.uqbar.arena.layout.VerticalLayout
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
			value <=> "tweet"
			width = 200
			]
		
		new TextBox(panel1)=>[
			value <=> "caracteresRestantes"
			width = 200
			title = "Caracteres Restantes"
					]
	}
	
}
