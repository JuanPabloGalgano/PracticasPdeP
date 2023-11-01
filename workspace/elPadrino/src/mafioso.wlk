import armas.*
import familia.*
import rango.*

class Mafioso{
	
	var property estaMuerto = false
	var property armas
	var rango
	var lealtad
	
	method duermeConLosPeces() = estaMuerto
	
	method cantidadDeArmas() = armas.size()
	
	method agregarArma(arma) = armas.add(arma)
	
	method despacharElegalmente() = rango.sabeDespacharElegantemente(self)
	
	method tieneArmaSutil() = armas.any{arma => arma.esSutil()}
	
	method realizarTrabajoResponsable(otraFamilia){ self.matarA(otraFamilia.peligroso()) }
	
	method matarA(otroMafioso) { rango.mataA(self ,otroMafioso) }
	
	method morirse() { estaMuerto = true }
	
	method armaCualquiera() = armas.anyOne()
	
	method armaMasCercana() = armas.first()
	
	method hacerLuto(){
		rango.hacerLuto()
		lealtad = lealtad * 1.1
	}
	
	method ascenderADonDe(unaFamilia){
		rango = new Don(subordinados = unaFamilia.subordinadosAnteriorDon())
	}
	
	method esSoldado() = rango.esSoldado()
}