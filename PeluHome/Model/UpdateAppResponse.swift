//
//  UpdateAppResponse.swift
//  PeluHome
//
//  Created by Resembrink Correa on 23/10/22.
//

import Foundation

struct AplicacionList:Decodable {
    let codigo: Int
    let version: String
    let plataforma: String
    let obligatorio: Bool
}

struct UpdateAppResponse:Decodable {
    let personalResponse: [AplicacionList]
}


