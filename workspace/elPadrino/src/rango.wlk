import armas.*
import familia.*

class Rango{
	
	method sabeDespacharELegantemente(_unMafioso)
	method atacaA(_unMafioso, otroMafioso)
	method hacerLuto(){}
	method esSoldado() = false
}

class Don inherits Rango{
	const property subordinados
	
	override method sabeDespacharELegantemente(_unMafioso) = true
	
	override method atacaA(_unMafioso, otroMafioso){
		subordinados.first().atacaA(otroMafioso)
	}	
		
	method subordinadoQuePuedeAscender(){
		self.subordinadosQueSabenDespacharElegantemente().max {subordinado => subordinado.lealtad()}
	}

	method subordinadosQueSabenDespacharElegantemente(){
		return subordinados.filter{subordinado => subordinado.despacharElegalmente()}
	}

}

class Subjefe inherits Rango{
	const subordinados
	
	override method sabeDespacharELegantemente(_unMafioso) = subordinados.any{subordinado => subordinado.tieneArmaSutil()}
	
	override method atacaA(unMafioso, otroMafioso){
		unMafioso.armaCualquiera().usarCon(otroMafioso)
	}
	
	override method hacerLuto(){
		
	}
}

class Soldado inherits Rango{
	
	override method sabeDespacharELegantemente(unMafioso) = unMafioso.tieneArmaSutil()
	
	override method atacaA(unMafioso, otroMafioso){
		unMafioso.armaMasCercana().usarCon(otroMafioso)
	}
	
	override method esSoldado() = true

}