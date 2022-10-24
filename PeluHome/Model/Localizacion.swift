//
//  Localizacion.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 20/12/20.
//

import Foundation

import Foundation

class Localizacion {
    var idLocalizacion:Int = 0
    var idUsuario:Int = 0
    var latitud:String = ""
    var longitud:String = ""
    var estadoActivo:Bool = false
    var estadoTomado:Bool = false
    
    init() {
    }
    
    func copiar(dato:[String:Any]) {
        idLocalizacion = dato["idLocalizacion"] as? Int ?? 0
        idUsuario = dato["idUsuario"] as? Int ?? 0
        latitud = dato["latitud"] as? String ?? ""
        longitud = dato["longitud"] as? String ?? ""
        estadoActivo = dato["estadoActivo"] as? Bool ?? false
        estadoTomado = dato["estadoTomado"] as? Bool ?? false
    }
    
    func copiarModeloDiccionario(localizacion: Localizacion) -> [String:Any] {
        var datosLocalizacion = [String:Any]()
        datosLocalizacion = [
                "idUsuario": localizacion.idUsuario,
                "latitud": localizacion.latitud,
                "longitud": localizacion.longitud,
                "estadoActivo": localizacion.estadoActivo,
                "estadoTomado": localizacion.estadoTomado
                ]
        return datosLocalizacion
    }

}
