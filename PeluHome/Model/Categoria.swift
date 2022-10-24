//
//  Categoria.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 10/18/20.
//

import Foundation

class Categoria {
    var idCategoria:Int = 0
    var nombre:String = ""
    var rutaImagen:String = ""
    var disponible:Bool = false
    
    init() {
    }
    
    func copiar(dato:[String:Any]) {
        idCategoria = dato["idCategoria"] as? Int ?? 0
        nombre = dato["nombre"] as? String ?? ""
        rutaImagen = dato["rutaImagen"] as? String ?? ""
        disponible = dato["disponible"] as? Bool ?? false
    }

}
