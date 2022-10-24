//
//  Programado.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 13/12/20.
//

import Foundation

class Programado {
    static let shared = Programado()
    
    var nNecesitados = 0
    var nSeleccionados = 0
    var serviciosSeleccionados = ""
    var listaServicios = [[String:Any]]()
    var pedidos = [Pedido]()
    var imagenDeposito = ""
    var formaPago = "Seleccionar"
    var profesionalesSeleccionados = false
    var accesoPosterior = false
}
