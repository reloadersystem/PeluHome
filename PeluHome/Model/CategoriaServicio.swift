//
//  CategoriaServicio.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 20/12/20.
//

import Foundation

class CategoriaServicio {
    var idProfesional:Int = 0
    var idCategoria:Int = 0
    var idServicio:Int = 0
    var nombreCategoria:String = ""
    var nombreServicio:String = ""
    var estado:Bool = false
    
    init() {
    }
    
    func crearCategoriaServicio(dato:[String:Any]) -> CategoriaServicio {
        let categoriaServicio = CategoriaServicio()
        
        categoriaServicio.idProfesional = 0
        categoriaServicio.idServicio = dato["idServicio"] as? Int ?? 0
        categoriaServicio.idCategoria = dato["idCategoria"] as? Int ?? 0
        categoriaServicio.nombreServicio = dato["nombreServicio"] as? String ?? ""
        categoriaServicio.nombreCategoria = dato["nombreCategoria"] as? String ?? ""
        categoriaServicio.estado = false
        
        return categoriaServicio
    }

}
