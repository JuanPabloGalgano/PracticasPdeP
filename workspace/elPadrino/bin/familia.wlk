import armas.*
import mafioso.* 

class Familia{
	
	const integrantes
	var don
	
	method peligroso() = self.integrantesVivos().max{integrante => integrante.cantidadArmas()}
		
	method integrantesVivos() = integrantes.filter{integrante => not integrante.estaMuerto()}
	
	method andenArmados() = integrantes.forEach{integrante => integrante.agregarArma(new Revolver(cantidadBalas = 6 ))}
	
	method ataqueSorpresa(otraFamilia){
		integrantes.forEach{integrante => integrante.realizarTrabajoResponsable(otraFamilia)}
	}
	
	method luto(){ integrantes.forEach{integrante => integrante.hacerLuto()}} //tengo que cambiar esto
	
	method elegirNuevoDon(){ don.subordinadoQuePuedeAscender().ascenderADonDe(self)}
	
	method ascenderADon(unIntegrante){ don = unIntegrante}
	
	method subordinadosAnteriorDon(){
		don.subordinados()
	}
	
	method soldadoConMasDe5Armas(){
		return self.soldadosDeLaFamilia().filter{soldado => soldado.cantidadArmas() > 5}
	}
	
	method soldadosDeLaFamilia(){ return integrantes.filter{integrante => integrante.esSoldado()}}
}