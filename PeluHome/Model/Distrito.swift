//
//  Distrito.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 8/12/20.
//

import Foundation

class Distrito {
    var codigo:Int = 0
    var descripcion:String = ""
    var provincia:Int = 0
    
    init() {
    }
    
    init(codigo: Int, descripcion: String, provincia: Int) {
        self.codigo = codigo
        self.descripcion = descripcion
        self.provincia = provincia
    }
    
    func copiar(dato:[String:Any]) {
        codigo = dato["codigo"] as? Int ?? 0
        descripcion = dato["descripcion"] as? String ?? ""
        provincia = dato["provincia"] as? Int ?? 0
    }

}
