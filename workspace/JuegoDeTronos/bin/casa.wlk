class Casa{
	
	var patrimonio
	var property miembros
	
	method sePuedeCasarCon(unPersonaje, otroPersonaje) = false
	
	method esRica() = patrimonio > 1000
	
	method patrimonioPorMiembro() = patrimonio / miembros.size()
	
	method miembrosVivosYSolteros(){
		miembros.filter{miembro => miembro.estaVivo()}.filter{miembro => not miembro.tienePareja()}
	}
	
	method perderFortuna(unPorcentaje) { patrimonio = (patrimonio * unPorcentaje) / 100}
}

class Lannister inherits Casa{
	
	override method sePuedeCasarCon(unPersonaje, otroPersonaje) = not unPersonaje.tienePareja()
}

class Stark inherits Casa{
	
	override method sePuedeCasarCon(unPersonaje, otroPersonaje) = unPersonaje.casa() != otroPersonaje.casa()
}

class GuardiaDeLaNoche inherits Casa{
	
}