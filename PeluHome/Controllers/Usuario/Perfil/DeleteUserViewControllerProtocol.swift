//
//  DeleteUserViewControllerProtocol.swift
//  PeluHome
//
//  Created by Resembrink Correa on 24/10/22.
//

import Foundation

protocol DeleteUserViewControllerProtocol: BaseViewProtocol {
    
    func showErrorMessage()
    func reloadDeleteData(_ dataSource: DeleteUserResponse)
}
