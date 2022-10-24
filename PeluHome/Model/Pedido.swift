//
//  Pedido.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 11/4/20.
//

import Foundation

class Pedido {
    var idPedido:Int = 0
    var numPedido:String = ""
    var servicio:String = ""
    var profesional:String = ""
    var puntos:Int = 0
    var estado:String = ""
    var codigoUsuario:Int = 0
    var direccion:String = ""
    var preferencias:String = ""
    var fecha:String = ""
    var hora:String = ""
    var formaPago:String = ""
    var precio:String = ""
    var usuario:String = ""
    var codigoServicio:String = ""
    var codigoProfesional:Int = 0
    var latitud:String = ""
    var longitud:String = ""
    var imagen:String = ""
    var calificacion:Int = 0
    // Nuevos parametros
    //"tokenProfesional": null,
    //"imagenPath": null,
    //"estrellas": 0.0,
    //"comentario": null,
    //"documento": null
    
    init() {
    }
    
    func copiar(dato:[String:Any]) {
        idPedido = dato["idPedido"] as? Int ?? 0
        numPedido = dato["numPedido"] as? String ?? ""
        servicio = dato["servicio"] as? String ?? ""
        profesional = dato["profesional"] as? String ?? ""
        puntos = dato["puntos"] as? Int ?? 0
        estado = dato["estado"] as? String ?? ""
        codigoUsuario = dato["codigoUsuario"] as? Int ?? 0
        direccion = dato["direccion"] as? String ?? ""
        preferencias = dato["preferencias"] as? String ?? ""
        fecha = dato["fecha"] as? String ?? ""
        hora = dato["hora"] as? String ?? ""
        formaPago = dato["formaPago"] as? String ?? ""
        precio = dato["precio"] as? String ?? ""
        usuario = dato["usuario"] as? String ?? ""
        codigoServicio = dato["codigoServicio"] as? String ?? ""
        codigoProfesional = dato["codigoProfesional"] as? Int ?? 0
        latitud = dato["latitud"] as? String ?? ""
        longitud = dato["longitud"] as? String ?? ""
        imagen = dato["imagen"] as? String ?? ""
        calificacion = dato["calificacion"] as? Int ?? 0
    }
    
    func copiarModeloDiccionario(pedido: Pedido) -> [String:Any] {
        var datosPedido = [String:Any]()
        datosPedido = [
                "idPedido": pedido.idPedido,
                "numPedido": pedido.numPedido,
                "servicio": pedido.servicio,
                "profesional": pedido.profesional,
                "puntos": pedido.puntos,
                "estado": pedido.estado,
                "codigoUsuario": pedido.codigoUsuario,
                "direccion": pedido.direccion,
                "preferencias": pedido.preferencias,
                "fecha": pedido.fecha,
                "hora": pedido.hora,
                "formaPago": pedido.formaPago,
                "precio": pedido.precio,
                "usuario": pedido.usuario,
                "codigoServicio": pedido.codigoServicio,
                "codigoProfesional": pedido.codigoProfesional,
                "latitud": pedido.latitud,
                "longitud": pedido.longitud,
                "imagen": pedido.imagen,
                "calificacion": pedido.calificacion,
                ]
        return datosPedido
    }

}
