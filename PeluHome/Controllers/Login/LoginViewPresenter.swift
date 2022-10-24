//
//  MisNotasPresenter.swift
//  CordonBleu
//
//  Created by Resembrink Correa on 14/10/22.
//

//
//  AsistenciaPresenter.swift
//  CordonBleu
//
//  Created by Resembrink Correa on 24/06/22.
//

import Foundation
import Alamofire

struct LoginViewPresenter {
    
    private let webService = UserWS()
    private unowned let controller : UpdateAppViewControllerProtocol
    init(controller: UpdateAppViewControllerProtocol) {
        self.controller = controller
    }
}

extension LoginViewPresenter {
    
   func doUppdateAppWithUser(){
       
       self.webService.updateApp { updateAppResponse in
           let arrayList = updateAppResponse
       } errorHandler: { errorMessage in
           print(errorMessage)
          // self.controller.showErrorMessage(errorMessage)
       }

    }
}



