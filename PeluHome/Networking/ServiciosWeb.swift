//
//  ServiciosWeb.swift
//  ProjectoD2
//
//  Created by Instructor Fredy Asencios on 7/14/19.
//  Copyright © 2019 Instructor Fredy Asencios. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class ServiciosWeb{
    
    class func obtenerDepartamentosAPI(completar:@escaping (_ departamentosAPI:[Departamento])->()){
        let urlString = "\(URLBASE)\(DEPARTAMENTO_WS)"
        var departamentos = [Departamento]()
        departamentos.append(Departamento.init(codigo: 0, descripcion: "Seleccione departamento"))
        AF.request(urlString, method: .get).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [[String:Any]] {
                for categoria in jsonDatos{
                    let nuevoDepartamento = Departamento()
                    nuevoDepartamento.copiar(dato: categoria)
                    departamentos.append(nuevoDepartamento)
                }
                completar(departamentos)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func obtenerProvinciasAPI(idDepartamento:Int, completar:@escaping (_ provinciasAPI:[Provincia])->()){
        let urlString = "\(URLBASE)\(PROVINCIA_WS)?departamento=\(idDepartamento)"
        var provincias = [Provincia]()
        provincias.append(Provincia.init(codigo: 0, descripcion: "Seleccione provincia", departamento: 0))
        AF.request(urlString, method: .get).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [[String:Any]] {
                for servicio in jsonDatos{
                    let nuevoProvincia = Provincia()
                    nuevoProvincia.copiar(dato: servicio)
                    provincias.append(nuevoProvincia)
                }
                completar(provincias)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func obtenerDistritosAPI(idProvincia:Int, completar:@escaping (_ provinciasAPI:[Distrito])->()){
        let urlString = "\(URLBASE)\(DISTRITO_WS)?provincia=\(idProvincia)"
        var distritos = [Distrito]()
        distritos.append(Distrito.init(codigo: 0, descripcion: "Seleccione distrito", provincia: 0))
        AF.request(urlString, method: .get).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [[String:Any]] {
                for servicio in jsonDatos{
                    let nuevoDistrito = Distrito()
                    nuevoDistrito.copiar(dato: servicio)
                    distritos.append(nuevoDistrito)
                }
                completar(distritos)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func obtenerDatosPersonalesAPI(codigo:Int, completar:@escaping (_ usuarioAPI:Usuario)->()){
        let urlString = "\(URLBASE)\(DATOS_PERSONALES_WS)?codigo=\(codigo)"
        AF.request(urlString, method: .get).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [String:Any] {
                var usuario = Usuario()
                usuario = usuario.copiarDiccionarioModelo(datosUsuario: jsonDatos)
                completar(usuario)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func actualizarDisponibilidadAPI(codigo:Int, estado:Int, completar:@escaping (_ successAPI:Bool, _ messageAPI:String)->()){
        let urlString = "\(URLBASE)\(DATOS_PERSONALES_WS)"
        let params = ["codigoUsuario":codigo, "estado":estado] as [String : Any]
        AF.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [String:Any] {
                let codigo = jsonDatos["mensajeCodigo"] as? Int ?? 0
                let message = jsonDatos["mensajeResultado"] as? String ?? ""
                let success = codigo == 200 ? true : false
                completar(success, message)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func grabarUsuarioAPI(usuario:Usuario, completar:@escaping (_ successAPI:Bool, _ messageAPI:String)->()){
        let urlString = "\(URLBASE)\(USUARIO_WS)"
        let params = usuario.copiarModeloDiccionario(usuario: usuario)
        AF.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [String:Any] {
                let codigo = jsonDatos["mensajeCodigo"] as? Int ?? 0
                let message = jsonDatos["mensajeResultado"] as? String ?? ""
                let success = codigo == 200 ? true : false
                completar(success, message)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func actualizarUsuarioAPI(usuario:Usuario, completar:@escaping (_ successAPI:Bool, _ messageAPI:String)->()){
        let urlString = "\(URLBASE)\(USUARIO_WS)"
        let params = usuario.copiarModeloDiccionario(usuario: usuario)
        AF.request(urlString, method: .put, parameters: params, encoding: JSONEncoding.default).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [String:Any] {
                let codigo = jsonDatos["mensajeCodigo"] as? Int ?? 0
                let message = jsonDatos["mensajeResultado"] as? String ?? ""
                let success = codigo == 200 ? true : false
                completar(success, message)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func autenticarCredencialesAPI(correo:String, clave:String, token:String, completar:@escaping (_ usuarioAPI:Usuario, _ successAPI:Bool, _ messageAPI:String)->()){
        let urlString = "\(URLBASE)\(LOGUIN_WS)"
        let params = ["correo":correo, "clave":clave, "token":token]
        AF.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [String:Any] {
                let codigo = jsonDatos["mensajeCodigo"] as? Int ?? 0
                let message = jsonDatos["mensajeResultado"] as? String ?? ""
                let success = codigo == 200 ? true : false
                var usuario = Usuario()
                usuario = usuario.copiarDiccionarioModelo(datosUsuario: jsonDatos)
                completar(usuario, success, message)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func obtenerCategoriasAPI(completar:@escaping (_ categoriasAPI:[Categoria])->()){
        let urlString = "\(URLBASE)\(CATEGORIA_WS)"
        var categorias = [Categoria]()
        AF.request(urlString, method: .get).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [[String:Any]] {
                for categoria in jsonDatos{
                    let nuevaCategoria = Categoria()
                    nuevaCategoria.copiar(dato: categoria)
                    categorias.append(nuevaCategoria)
                }
                completar(categorias)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func obtenerServiciosAPI(idCategoria:Int, completar:@escaping (_ serviciosAPI:[Servicio])->()){
        let urlString = "\(URLBASE)\(SERVICIO_WS)?idCategoria=\(idCategoria)"
        var servicios = [Servicio]()
        AF.request(urlString, method: .get).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [[String:Any]] {
                for servicio in jsonDatos{
                    let nuevoServicio = Servicio()
                    nuevoServicio.copiar(dato: servicio)
                    servicios.append(nuevoServicio)
                }
                completar(servicios)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func obtenerTodosServiciosAPI(completar:@escaping (_ categoriasServiciosAPI:[CategoriaServicio])->()){
        let urlString = "\(URLBASE)\(SERVICIO_WS)"
        var categoriasServicios = [CategoriaServicio]()
        AF.request(urlString, method: .get).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [[String:Any]] {
                for servicio in jsonDatos{
                    var nuevaCategoriaServicio = CategoriaServicio()
                    nuevaCategoriaServicio = nuevaCategoriaServicio.crearCategoriaServicio(dato: servicio)
                    categoriasServicios.append(nuevaCategoriaServicio)
                }
                completar(categoriasServicios)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func obtenerServiciosAdicionalesAPI(completar:@escaping (_ serviciosAPI:[Servicio])->()){
        let urlString = "\(URLBASE)\(SERVICIO_WS)"
        var servicios = [Servicio]()
        AF.request(urlString, method: .get).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [[String:Any]] {
                for servicio in jsonDatos{
                    let nuevoServicio = Servicio()
                    nuevoServicio.copiar(dato: servicio)
                    servicios.append(nuevoServicio)
                }
                completar(servicios)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func obtenerPedidosAPI(idUsuario:Int, rol:Int, completar:@escaping (_ pedidosAPI:[Pedido])->()){
        let urlString = "\(URLBASE)\(PEDIDO_WS)?usuario=\(idUsuario)&rol=\(rol)"
        var pedidos = [Pedido]()
        AF.request(urlString, method: .get).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [[String:Any]] {
                for pedido in jsonDatos{
                    let nuevoPedido = Pedido()
                    nuevoPedido.copiar(dato: pedido)
                    pedidos.append(nuevoPedido)
                }
                completar(pedidos)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func grabarPedidoAPI(pedido:Pedido, completar:@escaping (_ successAPI:Bool, _ messageAPI:String)->()){
        let urlString = "\(URLBASE)\(PEDIDO_WS)"
        let params = pedido.copiarModeloDiccionario(pedido: pedido)
        AF.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [String:Any] {
                let codigo = jsonDatos["mensajeCodigo"] as? Int ?? 0
                let message = jsonDatos["mensajeResultado"] as? String ?? ""
                let success = codigo == 200 ? true : false
                completar(success, message)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func calificarPedidoAPI(pedido:Int, comentarios:String, estrellas:Double, completar:@escaping (_ successAPI:Bool, _ messageAPI:String)->()){
        let urlString = "\(URLBASE)\(CALIFICAR_WS)"
        let params = ["pedido": pedido, "comentarios":comentarios,"estrellas":estrellas] as [String : Any]
        AF.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [String:Any] {
                let codigo = jsonDatos["mensajeCodigo"] as? Int ?? 0
                let message = jsonDatos["mensajeResultado"] as? String ?? ""
                let success = codigo == 200 ? true : false
                completar(success, message)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func actualizarPedidoAPI(pedido:Pedido, completar:@escaping (_ successAPI:Bool, _ messageAPI:String)->()){
        let urlString = "\(URLBASE)\(PEDIDO_WS)"
        let params = pedido.copiarModeloDiccionario(pedido: pedido)
        AF.request(urlString, method: .put, parameters: params, encoding: JSONEncoding.default).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [String:Any] {
                let codigo = jsonDatos["mensajeCodigo"] as? Int ?? 0
                let message = jsonDatos["mensajeResultado"] as? String ?? ""
                let success = codigo == 200 ? true : false
                completar(success, message)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func listarServiciosProfesionalesAPI(fecha: String, hora: String, listaServicios:[[String:Any]], completar:@escaping (_ profesionalesAPI:[Profesional])->()) {
        let urlString = "\(URLBASE)\(LISTAR_SERVICIOS_WS)"
        var profesionales = [Profesional]()
        let params = ["fecha": fecha, "hora": hora,"servicios": listaServicios] as [String : Any]
        //        var request = URLRequest(url: URL.init(string: urlString)!)
        //        let body = ["fecha": fecha, "hora": hora,"servicios": listaServicios] as [String : Any]
        //        request.httpMethod = "POST"
        //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //        request.httpBody = try! JSONSerialization.data(withJSONObject: body)
        AF.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON{ JSON  in
            //AF.request(request).responseJSON{ JSON in
            if let jsonDatos = JSON.value as? [[String:Any]] {
                for profesional in jsonDatos {
                    let nuevoProfesional = Profesional()
                    nuevoProfesional.copiar(dato: profesional)
                    profesionales.append(nuevoProfesional)
                }
                completar(profesionales)
                
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func grabarServiciosProfesionalAPI(idProfesional:Int, listaProfesionales:[[String:Any]], completar:@escaping (_ successAPI:Bool, _ messageAPI:String)->()){
        let urlString = "\(URLBASE)\(SERVICIO_PROFESIONAL_WS)"
        var request = URLRequest(url: URL.init(string: urlString)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: listaProfesionales)
        
        //AF.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON{ JSON  in
        AF.request(request).responseJSON{ JSON in
            if let jsonDatos = JSON.value as? [String:Any] {
                let codigo = jsonDatos["mensajeCodigo"] as? Int ?? 0
                let message = jsonDatos["mensajeResultado"] as? String ?? ""
                let success = codigo == 200 ? true : false
                completar(success, message)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    // Falta: Servicio Obtener Localizacion ???
    
    class func grabarLocalizacionAPI(localizacion:Localizacion, completar:@escaping (_ successAPI:Bool, _ messageAPI:String)->()){
        let urlString = "\(URLBASE)\(LOCALIZACION_WS)"
        let params = localizacion.copiarModeloDiccionario(localizacion: localizacion)
        AF.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [String:Any] {
                let codigo = jsonDatos["mensajeCodigo"] as? Int ?? 0
                let message = jsonDatos["mensajeResultado"] as? String ?? ""
                let success = codigo == 200 ? true : false
                completar(success, message)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func actualizarLocalizacionAPI(localizacion:Localizacion, completar:@escaping (_ successAPI:Bool, _ messageAPI:String)->()){
        let urlString = "\(URLBASE)\(LOCALIZACION_WS)"
        let params = localizacion.copiarModeloDiccionario(localizacion: localizacion)
        AF.request(urlString, method: .put, parameters: params, encoding: JSONEncoding.default).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [String:Any] {
                let codigo = jsonDatos["mensajeCodigo"] as? Int ?? 0
                let message = jsonDatos["mensajeResultado"] as? String ?? ""
                let success = codigo == 200 ? true : false
                completar(success, message)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func actualizarEstadoTomadoAPI(localizacion:Localizacion, completar:@escaping (_ successAPI:Bool, _ messageAPI:String)->()){
        let urlString = "\(URLBASE)\(LOCALIZACION_WS)"
        let params = localizacion.copiarModeloDiccionario(localizacion: localizacion)
        AF.request(urlString, method: .put, parameters: params, encoding: JSONEncoding.default).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [String:Any] {
                let codigo = jsonDatos["mensajeCodigo"] as? Int ?? 0
                let message = jsonDatos["mensajeResultado"] as? String ?? ""
                let success = codigo == 200 ? true : false
                completar(success, message)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func actualizarPagoAPI(codigo:Int, imagen:String, tipoPago:String, completar:@escaping (_ successAPI:Bool, _ messageAPI:String)->()){
        let urlString = "\(URLBASE)\(ACTUALIZAR_PAGO_WS)"
        let params = ["codigo":codigo, "imagen":imagen, "tipoPago":tipoPago] as [String : Any]
        AF.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [String:Any] {
                let codigo = jsonDatos["mensajeCodigo"] as? Int ?? 0
                let message = jsonDatos["mensajeResultado"] as? String ?? ""
                let success = codigo == 200 ? true : false
                completar(success, message)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func actualizarServiciosAdicionalesAPI(codigo:Int, serviciosAdicionales:String, completar:@escaping (_ successAPI:Bool, _ messageAPI:String)->()){
        let urlString = "\(URLBASE)\(ACTUALIZAR_SERVICIOS_ADICIONALES_WS)"
        let params = ["codigo":codigo, "serviciosAdicionales":serviciosAdicionales] as [String : Any]
        AF.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [String:Any] {
                let codigo = jsonDatos["mensajeCodigo"] as? Int ?? 0
                let message = jsonDatos["mensajeResultado"] as? String ?? ""
                let success = codigo == 200 ? true : false
                completar(success, message)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    // Por ordenar
    
    class func recuperarClaveAPI(correo:String, completar:@escaping (_ successAPI:Bool, _ messageAPI:String)->()){
        let urlString = "\(URLBASE)\(RECUPERAR_CLAVE_WS)?correo=\(correo)"
        AF.request(urlString, method: .get).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [String:Any] {
                let codigo = jsonDatos["mensajeCodigo"] as? Int ?? 0
                let message = jsonDatos["mensajeResultado"] as? String ?? ""
                let success = codigo == 200 ? true : false
                completar(success, message)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func obtenerParametrosAPI(completar:@escaping (_ parametros:[Parametros])->()){
        let urlString = "\(URLBASE)\(PARAMETROS_WS)"
        var parametros = [Parametros]()
        
//        parametros.append(Parametros.init(idParametro: 0, nombreParametro: "mp",valor:"v", activo:false))
        AF.request(urlString, method: .get).responseJSON{ JSON  in
            
         //   print(JSON.result)
            if let jsonDatos = JSON.value as? [[String:Any]] {
                for parametro in jsonDatos{
                    let nuevoParametros = Parametros()
                    nuevoParametros.copiarParametros(dato: parametro)
                    parametros.append(nuevoParametros)
                }
                completar(parametros)
            } else {
                print("error en el servicio")
            }
        }
    }
    
}
