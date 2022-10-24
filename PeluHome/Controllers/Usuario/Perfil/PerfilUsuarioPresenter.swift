//
//  p.swift
//  PeluHome
//
//  Created by Resembrink Correa on 24/10/22.
//



import Foundation
import Alamofire

struct PerfilUsuarioPresenter {
    
    private let webService = UserWS()
    private unowned let controller : DeleteUserViewControllerProtocol
    init(controller: DeleteUserViewControllerProtocol) {
        self.controller = controller
    }
}

extension PerfilUsuarioPresenter {
    
    func doDeleteAppWithUser(user: Int){
       
        self.webService.deleteAppUser(codigoUsuario: user, completion: { deleteUserResponse in
           let arrayList = deleteUserResponse
            self.controller.reloadDeleteData(deleteUserResponse)
       }, errorHandler: { errorMessage in
           print(errorMessage)
       })
    }
}



