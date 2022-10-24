//
//  MaterialView.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 7/12/20.
//

import UIKit

let SHADOW_COLOR:CGFloat = 157.0 / 255.0
let nombreFont = "Arial"

class MaterialView: UIView {
    
    override func awakeFromNib() {
//        layer.cornerRadius = 20.0
//        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.8).cgColor
//        layer.shadowOpacity = 0.8
//        layer.shadowRadius = 9.0
//        layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    class func textFieldEstiloLogin(textField: UITextField) -> UITextField {
        let borderColorTextField:UIColor = UIColor.systemGray3
        textField.borderStyle = .none
        textField.layer.borderColor = borderColorTextField.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 6.0
        textField.setLeftPaddingPoints(10.0)
        return textField
    }
    
    class func textFieldEstiloInvalido(textField: UITextField) -> UITextField {
        let borderColorTextField:UIColor = COLOR_PRIMARIO
        textField.borderStyle = .none
        textField.layer.borderColor = borderColorTextField.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 6.0
        textField.setLeftPaddingPoints(10.0)
        return textField
    }
    
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
