//
//  SizeButtonCustom.swift
//  PeluHome
//
//  Created by Resembrink Correa on 16/08/22.
//

import Foundation

import UIKit

@IBDesignable class SizeButtonCustom: UIButton {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if #available(iOS 15.0, *) {
 //           self.configuration?.background.cornerRadius = 10
//            self.configuration?.background.backgroundColor = UIColor(named: "colorTitle")
//            self.configuration?.baseForegroundColor = UIColor(named: "colorWhite")
            self.titleLabel?.font = .boldSystemFont(ofSize: 12)
        } else {
            // Fallback on earlier versions
        }
    }
}
