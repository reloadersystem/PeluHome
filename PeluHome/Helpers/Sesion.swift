//
//  Sesion.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 11/12/20.
//

import Foundation

class Sesion {
    static let shared = Sesion()
    init () {}
    
    let defaults = UserDefaults.standard
    
    func codigo() -> Int {
        let sesion = defaults.object(forKey: "datosSesion") as? [String:Any] ?? [String:Any]()
        return sesion["codigo"] as? Int ?? 0
    }
    
    func estadoSesion() -> Bool {
        let sesion = defaults.object(forKey: "datosSesion") as? [String:Any] ?? [String:Any]()
        return sesion["estadoSesion"] as? Bool ?? false
    }

    func correo() -> String {
        let sesion = defaults.object(forKey: "datosSesion") as? [String:Any] ?? [String:Any]()
        return sesion["correo"] as? String ?? ""
    }
    
    func clave() -> String {
        let sesion = defaults.object(forKey: "datosSesion") as? [String:Any] ?? [String:Any]()
        return sesion["clave"] as? String ?? ""
    }
   
    func token() -> String {
        let sesion = defaults.object(forKey: "datosSesion") as? [String:Any] ?? [String:Any]()
        return sesion["token"] as? String ?? ""
    }
    
}
