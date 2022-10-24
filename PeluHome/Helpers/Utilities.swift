//
//  Utilities.swift
//  PixelCommerce2
//
//  Created by Freddy Alexander Quispe Torres on 8/1/20.
//  Copyright © 2020 Academia moviles. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^[A-Za-z\\d$@$#!%*?&]{6,}")
        //let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func isPhoneValid(_ phone : String) -> Bool {
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", "^[09]{1}+[0-9]{8}")
        return phoneTest.evaluate(with: phone)
    }
    
    static func isEmailValid(_ email : String) -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,32}")
        return emailTest.evaluate(with: email)
    }
}
