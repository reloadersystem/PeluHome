//
//  AlertManager.swift
//  CordonBleu
//
//  Created by Resembrink Correa on 17/05/22.
//

import UIKit



protocol BaseViewProtocol: NSObjectProtocol{
    
    func showAutomaticAlertWithTitle(_ title:String , errorMessage: String)
   
}

extension BaseViewProtocol  where Self: UIViewController {
    
    
    func showAutomaticAlertWithTitle(_ title:String , errorMessage: String) {
        
        let alertController = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        
        self.present(alertController, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            alertController.dismiss(animated: true)
        }
        
    }
    
}

