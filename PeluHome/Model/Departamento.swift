//
//  Departamento.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 8/12/20.
//

import Foundation

class Departamento {
    var codigo:Int = 0
    var descripcion:String = ""
    
    init() {
    }
    
    init(codigo: Int, descripcion: String) {
        self.codigo = codigo
        self.descripcion = descripcion
    }
    
    func copiar(dato:[String:Any]) {
        codigo = dato["codigo"] as? Int ?? 0
        descripcion = dato["descripcion"] as? String ?? ""
    }

}
