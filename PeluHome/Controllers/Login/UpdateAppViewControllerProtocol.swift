//
//  UpdateAppViewControllerProtocol.swift
//  PeluHome
//
//  Created by Resembrink Correa on 23/10/22.
//

import Foundation



protocol UpdateAppViewControllerProtocol: BaseViewProtocol {
    
    func showErrorMessage()
    func reloadUpdateData(_ dataSource: [AplicacionList])
   
    
}
