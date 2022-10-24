//
//  Usuario.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 10/12/20.
//

import Foundation

class Usuario {
    var codigo:Int = 0
    var nombres:String = ""
    var apellidos:String = ""
    var correo:String = ""
    var documento:String = ""
    var celular:String = ""
    var clave:String = ""
    var departamento:Int = 0
    var provincia:Int = 0
    var distrito:Int = 0
    var direccion:String = ""
    var rol:String = ""
    var estado:String = ""
    var profesion:String = ""
    var token:String = ""
    var imagen:String = ""
    var disponible:Int = 0 //Apto para recibir o no pedidos
    var estadoActivo:Bool = false //Geolocalizacion activa o no
    
    init() {
    }
 
    func copiarModeloDiccionario(usuario: Usuario) -> [String:Any] {
        var datosUsuario = [String:Any]()
        datosUsuario = [
                "codigo": usuario.codigo,
                "nombres": usuario.nombres,
                "apellidos": usuario.apellidos,
                "profesion": usuario.profesion,
                "correo": usuario.correo,
                "documento": usuario.documento,
                "celular": usuario.celular,
                "clave": usuario.clave,
                "departamento": usuario.departamento,
                "provincia": usuario.provincia,
                "distrito": usuario.distrito,
                "direccion": usuario.direccion,
                "rol": usuario.rol,
                "estado": usuario.estado,
                "token": usuario.token,
                "imagen": usuario.imagen,
                "disponible": usuario.disponible,
                "estadoActivo": usuario.estadoActivo
                ]
        return datosUsuario
    }
    
    func copiarDiccionarioModelo(datosUsuario: [String:Any]) -> Usuario {
        let usuario = Usuario()
        usuario.codigo = datosUsuario["codigo"] as? Int ?? 0
        usuario.nombres = datosUsuario["nombres"] as? String ?? ""
        usuario.apellidos = datosUsuario["apellidos"] as? String ?? ""
        usuario.correo = datosUsuario["correo"] as? String ?? ""
        usuario.documento = datosUsuario["documento"] as? String ?? ""
        usuario.celular = datosUsuario["celular"] as? String ?? ""
        usuario.clave = datosUsuario["clave"] as? String ?? ""
        usuario.departamento = datosUsuario["departamento"] as? Int ?? 0
        usuario.provincia = datosUsuario["provincia"] as? Int ?? 0
        usuario.distrito = datosUsuario["distrito"] as? Int ?? 0
        usuario.direccion = datosUsuario["direccion"] as? String ?? ""
        usuario.rol = datosUsuario["rol"] as? String ?? ""
        usuario.estado = datosUsuario["estado"] as? String ?? ""
        usuario.profesion = datosUsuario["profesion"] as? String ?? ""
        usuario.token = datosUsuario["token"] as? String ?? ""
        usuario.imagen = datosUsuario["imagen"] as? String ?? ""
        usuario.disponible = datosUsuario["disponible"] as? Int ?? 0
        usuario.estadoActivo = datosUsuario["estadoActivo"] as! Bool
        return usuario
    }

}
