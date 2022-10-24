//
//  WebServices.swift
//  ProjectoD2
//
//  Created by Instructor Fredy Asencios on 7/14/19.
//  Copyright © 2019 Instructor Fredy Asencios. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class ServiciosWeb{
    
    class func obtenerCategoriasAPI(completar:@escaping (_ categoriasAPI:[Categoria])->()){
        let urlString = "\(URLBASE)\(CATEGORIA_WS)"
        var categorias = [Categoria]()
        AF.request(urlString, method: .get).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [[String:Any]] {
                for categoria in jsonDatos{
                    let nCategoria = Categoria()
                    nCategoria.copiar(dato: categoria)
                    categorias.append(nCategoria)
                }
                completar(categorias)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func obtenerServiciosAPI(idCategoria: Int, completar:@escaping (_ categoriasAPI:[Servicio])->()){
        let urlString = "\(URLBASE)\(SERVICIO_WS)?idCategoria=\(idCategoria)"
        var servicios = [Servicio]()
        AF.request(urlString, method: .get).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [[String:Any]] {
                for servicio in jsonDatos{
                    let nServicio = Servicio()
                    nServicio.copiar(dato: servicio)
                    servicios.append(nServicio)
                }
                completar(servicios)
            } else {
                print("error en el servicio")
            }
        }
    }
    
    class func listarServiciosProfesionalesAPI(listaServicios:[[String:Any]],completar:@escaping (_ profesionales:[Profesional])->()) {
        let urlString = "\(URLBASE)\(LISTAR_SERVICIOS_WS)"
        let params:[String:Any] = ["":listaServicios]
        AF.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON{ JSON  in
            if let jsonDatos = JSON.value as? [String:Any] {
                print(jsonDatos)
                //guard let data = jsonDatos["data"] as? [String:Any] else {return}
                //print(data)

                //completar(datoSesion,id,accessToken)

            } else {
                print("error en el servicio")
            }
        }
    }
//
//  //Enviar Orden
//    class func enviarOrden(idCliente:String,orden:[[String:Any]],address1:String,address2:String,latitud:String,longitud:String,token:String,completar:@escaping (_ success:Bool,_ idOrden:String)->()){
//        let urlString = "\(URLBASE)\(ENVIAR_ORDEN_WS)"
//        let params:[String:Any] = ["cliente_id":idCliente,"productos":orden,"address":address1,"secondaryAddress":address2,"latitude":latitud,"longitude":longitud]
//        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
//        AF.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON{ JSON  in
//            if let jsonDatos = JSON.value as? [String:Any] {
//                guard let datosOrden = jsonDatos["data"] as? [String:Any] else {return}
//                let idOrden = datosOrden["_id"] as? String ?? ""
//                let success = jsonDatos["success"] as? Bool ?? false
//                let mensaje = jsonDatos["message"] as? String ?? ""
//                print(mensaje)
//                completar(success,idOrden)
//
//            } else {
//                print("error en el servicio")
//            }
//        }
//    }
//
//  //Enviar Pago
//    class func enviarPago(idOrden:String,estadoPago:String,idCulqui:String,tokenPago:String,idCargo:String,aliasCard:String,digitsCard:String,payAmount:Double,payTipe:Int,factura:Bool,direccion:String,ruc:String,razonSocial:String,token:String,completar:@escaping (_ success:Bool)->()){
//        let urlString = "\(URLBASE)\(ENVIAR_PAGO_WS)"
//        let params:[String:Any] = [ "_id":idOrden,
//                                    "estado_pago":estadoPago,
//                                    "culqui_id":idCulqui,
//                                    "token_pago":tokenPago,
//                                    "cargo_id":idCargo,
//                                    "cardAlias":aliasCard,
//                                    "cardLastDigits":digitsCard,
//                                    "payableAmount":payAmount,
//                                    "payableType":payTipe,
//                                    "factura":factura,
//                                    "direccion":direccion,
//                                    "ruc":ruc,
//                                    "businessName":razonSocial]
//        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
//        AF.request(urlString, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON{ JSON  in
//            if let jsonDatos = JSON.value as? [String:Any] {
//                let success = jsonDatos["success"] as? Bool ?? false
//                let mensaje = jsonDatos["message"] as? String ?? ""
//                print(mensaje)
//                completar(success)
//
//            } else {
//                print("error en el servicio")
//            }
//        }
//    }
//
//  //Enviar Orden
//    class func listarOrdenes(idCliente:String,token:String,completar:@escaping (_ ordenes:[[String:Any]])->()){
//        let urlString = "\(URLBASE)\(ORDENES_WS)"
//        let params:[String:Any] = ["cliente_id":idCliente]
//        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
//        AF.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON{ JSON  in
//            if let jsonDatos = JSON.value as? [String:Any] {
//                guard let datosOrdenes = jsonDatos["data"] as? [[String:Any]] else {return}
//                completar(datosOrdenes)
//            } else {
//                print("error en el servicio")
//            }
//        }
//    }
//
//   //Enviar Token Push
//    class func enviarTokenPush(idCliente:String,deviceType:String,pushToken:String,token:String,completar:@escaping (_ success:Bool)->()){
//        let urlString = "\(URLBASE)\(ENVIAR_TOKEN_PUSH_WS)"
//        let params:[String:Any] = ["cliente_id":idCliente,"deviceType":deviceType,"push_token":pushToken]
//        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
//        AF.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON{ JSON  in
//            if let jsonDatos = JSON.value as? [String:Any] {
//                guard let message = jsonDatos["message"] as? String else {return}
//                guard let success = jsonDatos["success"] as? Bool else {return}
//                print(message)
//                completar(success)
//            } else {
//                print("error en el servicio")
//            }
//        }
//    }
//
//  //Complementarios
//    class func descargarImagenes(dataArray:[[String:Any]],success:@escaping ()->()){
//        for item in dataArray{
//            let nomImg = item["imagen"] as? String ?? ""
//            let urlImg = "\(URLImagenes)\(nomImg)"
//            let filePath = filePathfunc(nombreArchivo: nomImg)
//
//            if (!fileManager.fileExists(atPath: filePath))  {
//                AF.request(urlImg).responseImage { response in
//                    if case .success(let imagen) = response.result {
//                        print("image downloaded: \(imagen)")
//                        print("grabando en local")
//                        let urlToImage = URL(fileURLWithPath: filePath)
//                            do {
//                                let data = imagen.pngData() as NSData?
//                                try data?.write(to: urlToImage, options: [.atomic])
//                            }catch{
//                                //error
//                        }
//                    }
//                }
//            }
//        }
//        success()
//    }
//
//    class func descargarImagenesArray(dataArray:[[String:Any]],success:@escaping ()->()){
//        for item in dataArray{
//            let imagenArray = item["imagen"] as? [String] ?? [String]()
//            let nomImg = imagenArray[0]
//            let urlImg = "\(URLImagenes)\(nomImg)"
//            let filePath = filePathfunc(nombreArchivo: nomImg)
//
//            if (!fileManager.fileExists(atPath: filePath))  {
//                AF.request(urlImg).responseImage { response in
//                    if case .success(let imagen) = response.result {
//                        print("image downloaded: \(imagen)")
//                        print("grabando en local")
//                        let urlToImage = URL(fileURLWithPath: filePath)
//                            do {
//                                let data = imagen.pngData() as NSData?
//                                try data?.write(to: urlToImage, options: [.atomic])
//                            }catch{
//                                //error
//                        }
//                    }
//                }
//            }
//        }
//        success()
//    }
//
//    class func descargarImagenesDetalle(dataArray:[String:Any],success:@escaping ()->()){
//        let imagenArray = dataArray["imagen"] as? [String] ?? [String]()
//        let nomImg = imagenArray[0]
//        let urlImg = "\(URLImagenes)\(nomImg)"
//        let filePath = filePathfunc(nombreArchivo: nomImg)
//
//        if (!fileManager.fileExists(atPath: filePath))  {
//            AF.request(urlImg).responseImage { response in
//                if case .success(let imagen) = response.result {
//                    print("image downloaded: \(imagen)")
//                    print("grabando en local")
//                    let urlToImage = URL(fileURLWithPath: filePath)
//                        do {
//                            let data = imagen.pngData() as NSData?
//                            try data?.write(to: urlToImage, options: [.atomic])
//                        }catch{
//                            //error
//                    }
//                }
//            }
//        }
//        success()
//    }
//
//    class func filePathfunc(nombreArchivo:String)->String{
//        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//        let carpeta = "/"
//        let fileName = "\(carpeta)\(nombreArchivo)"
//        let filePath =  documentPath + fileName
//        print(filePath)
//        return filePath
//    }
//
//    class func syncImageConAlamo(nomImg:String,succesWith:@escaping (_ imageURLLocal:String)->()){
//        let urlImg = "\(URLImagenes)\(nomImg)"
//        let filePath = filePathfunc(nombreArchivo: nomImg)
//        if (!fileManager.fileExists(atPath: filePath))  {
//        AF.request(urlImg).responseImage { response in
//            if case .success(let imagen) = response.result {
//               print("image downloaded: \(imagen)")
//               print("grabando en local")
//               let urlToImage = URL(fileURLWithPath: filePath)
//                   do {
//                       let data = imagen.pngData() as NSData?
//                       try data?.write(to: urlToImage, options: [.atomic])
//                       succesWith(filePath)
//                   }catch{
//                       //error
//                   }
//               }
//            }
//       } else {
//           succesWith(filePath)
//           print("recuperando desde local")
//       }
//       succesWith(filePath)
//   }
}
