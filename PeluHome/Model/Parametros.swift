//
//  Parametros.swift
//  PeluHome
//
//  Created by Resembrink Correa on 9/08/22.
//

import Foundation


class Parametros {
    
    var idParametro:Int = 0
    var nombreParametro:String = ""
    var valor:String = ""
    var activo:Bool = false
    
    init() {
        
    }

    init(idParametro: Int, nombreParametro: String, valor:String, activo:Bool) {
        self.idParametro = idParametro
        self.nombreParametro = nombreParametro
        self.valor = valor
        self.activo = activo
    }
    
    func copiarParametros(dato:[String:Any]) {
        idParametro = dato["idParametro"] as? Int ?? 0
        nombreParametro = dato["nombreParametro"] as? String ?? ""
        valor = dato["valor"] as? String ?? ""
        activo = dato["activo"] as? Bool ?? false
    }

}

