//
//  Clousures.swift
//  PeluHome
//
//  Created by Resembrink Correa on 23/10/22.
//

import Foundation


typealias updateAppHandler = (_ updateAppResponse: UpdateAppResponse) -> Void

typealias deleteUserHandler = (_ deleteUserHandler: DeleteUserResponse) -> Void

typealias ErrorHandler = (_ errorMessage: String) -> Void

