class Pajaro{
	
	var property ira
	var property enojos
	var property fuerza
	
	method aumentarFuerza(){}
	
	method enojarse() { 
		self.aumentarFuerza()
		enojos++
	}
	
	method esFuerte() = fuerza > 50
	
	method esAfectadoPor(unEvento) = unEvento.afectaA(self)
	
	method seTranquiliza(){ ira = ira - 5}
	
	method lanzarA(islaPajaro) { self.impactarContra(islaPajaro) }
	
	method impactarContra(islaPajaro){
		if(self.puedeRomper(islaPajaro.obstaculos().first())){
		islaPajaro.derribaronObstaculo()
		} 
	}
	
	method puedeRomper(unObstaculo) = unObstaculo.resistencia() > fuerza
}

class Comun inherits Pajaro{
	
	override method aumentarFuerza() { fuerza = ira * 2 }
}

class Red inherits Pajaro{
	
	override method aumentarFuerza() {fuerza = ira * 10 * enojos}
}

class Bomb inherits Pajaro{
	
	var maximoFuerza
	
	override method aumentarFuerza() {fuerza = maximoFuerza.max(ira * 2)}
}

class Chuck inherits Pajaro{
	
	var estado
	var velocidad
	
	override method aumentarFuerza() {fuerza = self.fuerzaVelocidad() * estado.multiplicadorFuerza(self)}
	
	method fuerzaVelocidad() { 
	if(velocidad < 80){
		return 150
	}
	return 150 + 5 * (velocidad - 80)
	}
	
	override method seTranquiliza() {}
}

object enojado{
	const property multiplicadorFuerza = 2	
}

object tranquilo{
	const property multiplicadorFuerza = 1	
}

class Terence inherits Pajaro{
	
	var multiplicador
	
	override method aumentarFuerza() { fuerza = ira * enojos * multiplicador }
}

class Matilda inherits Pajaro{
	
	var huevos
	
	override method aumentarFuerza() {fuerza = ira * 2 + self.sumaHuevos()} 
	
	method sumaHuevos() = huevos.sum{huevo => huevo.fuerzaPorPeso()}
	
	override method enojarse(){
		super()
		self.ponerHuevo(new Huevo(peso = 2))
	}
	
	method ponerHuevo(unHuevo) { huevos.add(unHuevo)}
}

class Huevo{
	var peso
	
	method fuerzaPorPeso() = peso
}

