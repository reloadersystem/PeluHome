//
//  ExtensionView.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 10/19/20.
//

import UIKit

extension UIView {
    func redondeoLateralDerecho(radio: Double) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: radio, height: radio))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    func redondeoLateralIzquierdo(radio: Double) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: radio, height: radio))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    func redondeoSuperiorDerecho(radio: Double) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight], cornerRadii: CGSize(width: radio, height: radio))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    func redondeoInferiorDerecho(radio: Double) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomRight], cornerRadii: CGSize(width: radio, height: radio))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
