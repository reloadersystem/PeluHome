//
//  Utilitarios.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 10/12/20.
//

import Foundation
import UIKit

class Utilitarios {
    
    static func esCorreoValido(_ correo : String) -> Bool {
        let testCorreo = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,32}")
        return testCorreo.evaluate(with: correo)
    }
    
    static func esDocumentoValido(_ documento : String) -> Bool {
        let testDocumento = NSPredicate(format: "SELF MATCHES %@", "^[0-9]{8}")
        return testDocumento.evaluate(with: documento)
    }
    
    static func esCelularValido(_ celular : String) -> Bool {
        let testCelular = NSPredicate(format: "SELF MATCHES %@", "^[09]{1}+[0-9]{8}")
        return testCelular.evaluate(with: celular)
    }
    
    static func esClaveValida(_ clave : String) -> Bool {
        let testClave = NSPredicate(format: "SELF MATCHES %@", "^[A-Za-z\\d$@$#!%*?&]{6,}")
        return testClave.evaluate(with: clave)
    }

}
