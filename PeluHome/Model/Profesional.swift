//
//  Profesional.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 11/3/20.
//

import Foundation

class Profesional {
    var idServicioProfesional:Int = 0
    var idServicio:Int = 0
    var idProfesional:Int = 0
    var nombres:String = ""
    var apellidos:String = ""
    var profesion:String = ""
    var puntos:Int = 0
    var estado:Bool = false
    var idServicios:String = ""
    var nombreServicio:String = ""
    var imagen:String = ""
    var calificacion:Double = 0.0
    
    init() {
    }
    
    func copiar(dato:[String:Any]) {
        idServicioProfesional = dato["idCategoria"] as? Int ?? 0
        idServicio = dato["idServicio"] as? Int ?? 0
        idProfesional = dato["idProfesional"] as? Int ?? 0
        nombres = dato["nombres"] as? String ?? ""
        apellidos = dato["apellidos"] as? String ?? ""
        profesion = dato["profesion"] as? String ?? ""
        puntos = dato["puntos"] as? Int ?? 0
        estado = dato["estado"] as? Bool ?? false
        idServicios = dato["idServicios"] as? String ?? ""
        nombreServicio = dato["nombreServicio"] as? String ?? ""
        imagen = dato["imagen"] as? String ?? ""
        calificacion = dato["calificacion"] as? Double ?? 0
    }
    
    func copiarModeloDiccionario(profesional: Profesional) -> [String:Any] {
        var datosProfesional = [String:Any]()
        datosProfesional = [
                "idServicioProfesional": profesional.idServicioProfesional,
                "idServicio": profesional.idServicio,
                "idProfesional": profesional.idProfesional,
                "nombres": profesional.nombres,
                "apellidos": profesional.apellidos,
                "profesion": profesional.profesion,
                "puntos": profesional.puntos,
                "estado": profesional.estado,
                "idServicios": profesional.idServicios,
                "nombreServicio": profesional.nombreServicio,
                "imagen": profesional.imagen,
                "calificacion": profesional.calificacion
                ]
        return datosProfesional
    }

}
