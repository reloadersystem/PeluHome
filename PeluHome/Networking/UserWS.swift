//
//  UserWS.swift
//  PeluHome
//
//  Created by Resembrink Correa on 23/10/22.
//

import Foundation
import Alamofire
import SwiftyJSON

struct UserWS {
    
    func updateApp(completion: @escaping updateAppHandler, errorHandler:@escaping ErrorHandler ) {
        
        let  urlString = "\(URLBASE)version"
        
        let request = AF.request(urlString, method: .get, encoding: JSONEncoding.default)
        
        request.response {dataResponse in
            
            
            guard let data =  dataResponse.data else {
                errorHandler("No hay  data para leer")
                return
            }
            
            let trama = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            print("trama Ficha: \(trama ?? "Error en la lectura de la  trama")")
            
            let jsonDecoder = JSONDecoder()
            guard let personalResponse =  try? jsonDecoder.decode(UpdateAppResponse.self, from: data) else {
                errorHandler("Error en el servicio")
                return
            }
            
            completion(personalResponse)
        }
    }
    
    func deleteAppUser(codigoUsuario: Int ,completion: @escaping deleteUserHandler, errorHandler:@escaping ErrorHandler ) {
        
        let  urlString = "\(URLBASE)usuario/eliminar"
        
        
        let autorization: HTTPHeaders = [
            "Content-type": "application/json"
        ]

        let user = DeleteUserRequest(codigoUsuario: codigoUsuario)

        let data = try! JSONEncoder.init().encode(user)
        let json = try! JSON.init(data: data)
        let dictionary = json.dictionaryObject

        let request = AF.request(urlString, method: .post, parameters:dictionary, encoding: JSONEncoding.default)
        request.response {dataResponse in
            
            
            guard let data =  dataResponse.data else {
                errorHandler("No hay  data para leer")
                return
            }
            
            let trama = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            print("trama Ficha: \(trama ?? "Error en la lectura de la  trama")")
            
            let jsonDecoder = JSONDecoder()
            guard let personalResponse =  try? jsonDecoder.decode(DeleteUserResponse.self, from: data) else {
                errorHandler("Error en el servicio")
                return
            }
            
            completion(personalResponse)
        }
    }
}
                                    
                                        
