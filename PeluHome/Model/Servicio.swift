//
//  Servicio.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 10/18/20.
//

import Foundation

class Servicio {
    var idServicio:Int = 0
    var idCategoria:Int = 0
    var nombreServicio:String = ""
    var nombreCategoria:String = ""
    var rutaImagen:String = ""
    var precio:String = ""
    var disponible:Bool = false
    
    init() {
    }
    
    func copiar(dato:[String:Any]) {
        idServicio = dato["idServicio"] as? Int ?? 0
        idCategoria = dato["idCategoria"] as? Int ?? 0
        nombreServicio = dato["nombreServicio"] as? String ?? ""
        nombreCategoria = dato["nombreCategoria"] as? String ?? ""
        precio = dato["precio"] as? String ?? ""
        rutaImagen = dato["rutaImagen"] as? String ?? ""
        disponible = dato["disponible"] as? Bool ?? false
    }
    
    class func obtenerServicioById(idServicio: String, servicios: [Servicio]) -> Servicio {
        for servicio in servicios {
            let id = String(servicio.idServicio)
            if id == idServicio {
                return servicio
            }
        }
        return Servicio()
    }
}
