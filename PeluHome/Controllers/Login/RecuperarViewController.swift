//
//  RecuperarViewController.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 20/12/20.
//

import UIKit

class RecuperarViewController: UIViewController {
    
    @IBOutlet weak var txtCorreo: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurarTextFields()
    }
    
    @IBAction func volverAtras(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func recuperarClave(_ sender: UIButton) {
        configurarTextFields()
        // Registro de usuario
        let error = validarCampos()

        if error != nil {
            let alert = UIAlertController(title: "App PeluHome", message: error, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert,animated: true)
        } else {
            let correo = txtCorreo.text ?? ""
            
            ServiciosWeb.recuperarClaveAPI(correo: correo) { (success, message) in
                if success {
                    let alert = UIAlertController(title: "App PeluHome", message: "Correo enviado", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Continuar", style: .default) { (action) in
                        // Regresar a Login
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    alert.addAction(action)
                    self.present(alert,animated: true)
                } else {
                    let alert = UIAlertController(title: "App PeluHome", message: message, preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert,animated: true)
                }
            }
        }
    }
    
    func configurarTextFields() {
        txtCorreo = MaterialView.textFieldEstiloLogin(textField: txtCorreo)
    }
    
    func validarCampos() -> String? {
        let correoLimpio = txtCorreo.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        if Utilitarios.esCorreoValido(correoLimpio) == false {
            txtCorreo = MaterialView.textFieldEstiloInvalido(textField: txtCorreo)
            return "Por favor ingresar un correo valido"
        }
        
        return nil
    }
}
