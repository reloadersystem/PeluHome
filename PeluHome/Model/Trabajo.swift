//
//  Trabajo.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 2/12/20.
//

import Foundation

class Trabajo {
    var idTrabajo:Int = 0
    var servicio:String = ""
    var cliente:String = ""
    var puntos:Int = 0
    var estado:String = ""
    var codigoUsuario:Int = 0
    var direccion:String = ""
    var preferencias:String = ""
    var fecha:String = ""
    var hora:String = ""
    var formaPago:String = ""
    var precio:String = ""
    
    init() {
    }
    
    func copiar(dato:[String:Any]) {
        idTrabajo = dato["idPedido"] as? Int ?? 0
        servicio = dato["servicio"] as? String ?? ""
        cliente = dato["profesional"] as? String ?? ""
        puntos = dato["puntos"] as? Int ?? 0
        estado = dato["estado"] as? String ?? ""
        codigoUsuario = dato["codigoUsuario"] as? Int ?? 0
        direccion = dato["direccion"] as? String ?? ""
        preferencias = dato["preferencias"] as? String ?? ""
        fecha = dato["fecha"] as? String ?? ""
        hora = dato["hora"] as? String ?? ""
        formaPago = dato["formaPago"] as? String ?? ""
        precio = dato["precio"] as? String ?? ""
    }
}
