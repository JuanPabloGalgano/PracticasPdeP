class Evento{
	
	method afectaA(unPajaro)
}

class MenejoDeIra inherits Evento{
	
	override method afectaA(unPajaro) { unPajaro.seTranquiliza() }
}

class InvasionDeCerditos inherits Evento{
	
	const cantidadCerditos
	
	override method afectaA(unPajaro){
		const cantidadDeVeces = cantidadCerditos / 100
		cantidadDeVeces.times{pajaro => unPajaro.enojarse()}
	}
}

class FiestaSopresa inherits Evento{
	
	const homenajeados
	
	override method afectaA(unPajaro){
		homenajeados.forEach{homenajeado => homenajeado.enojarse()}
	}
}

class SerieDeEventos inherits Evento{
	
	const eventos
	
	override method afectaA(unPajaro){
		eventos.forEach{evento => evento.afectaA(unPajaro)}
	}
}