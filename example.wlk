object paquete{
    var estaPago = false
    var destino = laMatrix
    
    method estaPago() = estaPago
    method pagarPaquete(){ estaPago = true}
    method puedeEntegarse(unMensajero){
        return
        destino.dejaPasarMensajero(unMensajero) &&
        self.estaPago()
    }
    method precioTotal() = 50
}
object puenteDeBrooklyn{
    method dejaPasarMensajero(unMensajero){
        return
        unMensajero.pesp() < 1000
    }
}
object laMatrix{
    method dejaPasarMensajero(unMensajero){
        return
        unMensajero.puedeLlamar()
    }
}

object Roberto{
    var transporte = bicicleta
    method peso() = 90 + transporte.peso()
    method puedeLlamar() = false
    method cambiarTransporte(unTransporte){transporte = unTransporte}

}
object ChukNorris{
    method peso() = 80
    method puedeLlamar() = true
}

object Neo{
    var tieneCredito = true
    method peso() = 0
    method puedeLlamar() = tieneCredito
    method cargarCredito(){tieneCredito = true}
    method agotarCredito(){tieneCredito = false}
}

object bicicleta{
    method peso() = 5
}

object camion{
    var acoplados = 1
    method cantidadAcoplados(unaCantidad){acoplados = unaCantidad}
    method peso() = acoplados * 500
}

object empresaMensajeria{
    /*const mensajeros = #{} conjunto se caracteriza por usar #{}* son del clase SET,los tiene desordenados*/
    const mensajeros = []
    const paquetesPendientes = []
    const paquetesEnviados = []

    method mensajeros() = mensajeros

    method contratar(unMensajero) = mensajeros.add(unMensajero)
    method despedir(unMensajero) = mensajeros.remove(unMensajero)
    method esGrande() = mensajeros.size() > 2

    method puedeEntregarsePaquete(){
    return paquete.puedeEntegarse(mensajeros.first())
    }
    method pesoUltimoMensajero() = mensajeros.last().peso()

    method puedeEntregarse(unPaquete){
        return 
            mensajeros.any({m => unPaquete.puedeEntegarse(m)})
    }

    method losQuePuedenEntregar(unPaquete){
        return 
            mensajeros.filter({m => unPaquete.puedeEntegarse(m)})
    }
    method mensajeriaSobrePeso(){
        return
        self.pesosMensajeros() / mensajeros.size() > 500 /*conseguimos el promedio dividiendo la cantidad de la lista*/
    }
    method pesosMensajeros() = mensajeros.sum({m => m.peso()})

    method enviar(unPaquete){
        if(self.puedeEntregarse(unPaquete)){
            paquetesEnviados.add(unPaquete)
        }
        else{
            paquetesPendientes.add(unPaquete)
        }
    }

    method facturacion(){
            paquetesEnviados.sum({p => p.precioTotal()})
    }
    method enviarPaquetes(listaDePaquetes){
        listaDePaquetes.forEach({p => self.enviar(p)})
    }

    method enviarPendienteMasCaro(){
        if(self.puedeEntregarse(self.paquetePendienteMasCaro())){
            self.enviar(self.paquetePendienteMasCaro())
            paquetesPendientes.remove(self.paquetePendienteMasCaro())    
        }
    }
    method paquetePendienteMasCaro() {
        return 
            paquetesPendientes.max({p => p.precioTotal()})
    }
}

object paquetito{
    method estaPago() = true
    method puedeEntregarse(unMensajero) = true
    method precioTotal() = 0
}

object paqueton{
    const destinos = []
    var importePagado = 0
    method agregarDestino(unDestino) = destinos.add(unDestino)

    method puedeEntregarse(unMensajero){
        return
            self.estaPago() && self.puedePasarPorDestino(unMensajero)
    }

    method puedePasarPorDestino(unMensajero){
        return destinos.all({d => d.dejaPasarMensajero(unMensajero)})
    }

    method precioTotal() = 100 * destinos.size()

    method estaPago(){
        return importePagado >= self.precioTotal() 
    }

    method pagar(unImporte){
        importePagado = importePagado 
    }
}
