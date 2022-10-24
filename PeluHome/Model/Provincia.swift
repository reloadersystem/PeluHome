//
//  Provincia.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 8/12/20.
//

import Foundation

class Provincia {
    var codigo:Int = 0
    var descripcion:String = ""
    var departamento:Int = 0
    
    init() {
    }
    
    init(codigo: Int, descripcion: String, departamento: Int) {
        self.codigo = codigo
        self.descripcion = descripcion
        self.departamento = departamento
    }
    
    func copiar(dato:[String:Any]) {
        codigo = dato["codigo"] as? Int ?? 0
        descripcion = dato["descripcion"] as? String ?? ""
        departamento = dato["departamento"] as? Int ?? 0
    }

}
