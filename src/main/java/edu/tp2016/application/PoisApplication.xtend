package edu.tp2016.application

import org.uqbar.arena.Application
import edu.tp2016.vista.LoginWindow

class PoisApplication extends Application{
	
	new(PoisBootstrap bootstrap) {
		super(bootstrap)
	}
	
	override protected createMainWindow() {
		new LoginWindow(this)
	}

	static def void main(String[] args) {
		new PoisApplication(new PoisBootstrap).start()
	}
}