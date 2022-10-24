//
//  LoginViewController.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 3/12/20.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    var estadoRecordar = false
    let anchoVista = UIScreen.main.bounds.width
    let altoVista = UIScreen.main.bounds.height
    @IBOutlet weak var despuesButton: BorderCornerButton!
    
    @IBOutlet var visualBackgroundView: UIVisualEffectView!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnRecordar: UIButton!
    
    @IBOutlet weak var viewBackgroundModal: UIView!
    lazy private var presenter = LoginViewPresenter(controller: self)
    
    @IBOutlet var popupView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configuracionNavigationBar()
        configurarTextFields()
        // self.presentModal()
        
        visualBackgroundView.bounds =  self.view.bounds
        //        visualBackgroundView.backgroundColor = .black
        visualBackgroundView.alpha = 0.1
        viewBackgroundModal.layer.cornerRadius = 20
        visualBackgroundView.frame = CGRect(x: 0, y: 0, width: anchoVista, height: altoVista)
        popupView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.40)
        //TODO: eliminar usuarios falta
        UpdateAppTienda()
    }
    
    func UpdateAppTienda(){
        
        let  urlString = "\(URLBASE)version"
        AF.request(urlString, method: .get, headers: nil).responseJSON { response
            in
            
            switch response.result {
                
            case .success(let value):
                
                if let json = value as? [[String:Any]]
                {
                    //let  estado = json[1]["obligatorio"] as! Bool
                    let estado  =  true
                    
                    if(estado){
                        self.despuesButton.isEnabled =  false
                        //let versionServer = json[1]["version"]as! String
                        let versionServer = "2.0.3"
                        let versionXcode = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "1.0"
                        self.compareVersion(current: versionXcode as! String, appStore: versionServer, estado: estado)
                        
                    }else{
                        self.despuesButton.isEnabled =  true
                        let versionServer = "2.0.3"
                        let versionXcode = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "1.0"
                        self.compareVersion(current: versionXcode as! String, appStore: versionServer, estado: estado)
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func compareVersion(current: String, appStore: String, estado: Bool){
        
        let versionCompare = current.compare(appStore, options: .numeric)
        if versionCompare == .orderedSame {
            print("same version")
        } else if versionCompare == .orderedAscending {
            // will execute the code here
            print("ask user to update")
            self.initUpdateMessage()
        } else if versionCompare == .orderedDescending {
            // execute if current > appStore
            print("don't expect happen...")
        }
    }
    
    func animateIn(desiredView:UIView){
        let backgroundview = self.view!
        backgroundview.addSubview(desiredView)
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = backgroundview.center
        UIView.animate(withDuration: 0.3) {
            desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            desiredView.alpha = 1
        }
    }
    
    @IBAction func updateAfterButton(_ sender: Any) {
        animateOut(desiredView: popupView)
        animateOut(desiredView: visualBackgroundView)
    }
    
    @IBAction func updateNowButton(_ sender: Any) {
        animateOut(desiredView: popupView)
        animateOut(desiredView: visualBackgroundView)
        
        self.openAppStore()
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        configuracionNavigationBar()
        estadoRecordarSesion()
        // self.initUpdateMessage()
        
    }
    
    func initUpdateMessage(){
        animateIn(desiredView: visualBackgroundView)
        animateIn(desiredView: popupView)
    }
    
    
    @IBAction func recordarCredenciales(_ sender: UIButton) {
        estadoRecordar = !estadoRecordar
        let imagen = estadoRecordar ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square")
        btnRecordar.setBackgroundImage(imagen, for: .normal)
    }
    
    @IBAction func loguearUsuario(_ sender: UIButton) {
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
            let clave = txtPassword.text ?? ""
            let token = Sesion.shared.token()
            
            ServiciosWeb.autenticarCredencialesAPI(correo: correo, clave: clave, token: token) { (usuario, success, message) in
                if success {
                    let datosSesion = ["codigo": usuario.codigo,"estadoSesion": self.estadoRecordar,"correo":correo,"clave":clave] as [String : Any]
                    self.defaults.set(datosSesion,forKey: "datosSesion")
                    
                    switch usuario.estado {
                    case "Registrado": self.mostrarAlert(message: "Profesional pendiente de activacion")
                    case "Desactivado": self.mostrarAlert(message: "Profesional se encuentra bloqueado")
                    case "Activo": self.irAMenu(rol: usuario.rol)
                    default: print("")
                    }
                } else {
                    self.mostrarAlert(message: message)
                }
            }
        }
    }
    
    @IBAction func irARecuperar(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let _vc = storyBoard.instantiateViewController(withIdentifier: "RecuperarVC") as! RecuperarViewController
        _vc.modalPresentationStyle = .currentContext
        self.navigationController?.pushViewController(_vc, animated: true)
    }
    
    @IBAction func irARegistroUsuario(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let _vc = storyBoard.instantiateViewController(withIdentifier: "RegistroUsuarioVC") as! RegistroUsuarioViewController
        //_vc.modalPresentationStyle = .currentContext
        self.navigationController?.pushViewController(_vc, animated: true)
    }
    
    @IBAction func irARegistroProfesional(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let _vc = storyBoard.instantiateViewController(withIdentifier: "RegistroProfesional1VC") as! RegistroProfesional1ViewController
        //_vc.modalPresentationStyle = .currentContext
        self.navigationController?.pushViewController(_vc, animated: true)
    }
    
    @IBAction func irACategoriasIniciales(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let _vc = storyBoard.instantiateViewController(withIdentifier: "CategoriasInicialesVC") as! CategoriasInicialesViewController
        self.navigationController?.pushViewController(_vc, animated: true)
    }
    
    func configuracionNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func configurarTextFields() {
        txtCorreo = MaterialView.textFieldEstiloLogin(textField: txtCorreo)
        txtPassword = MaterialView.textFieldEstiloLogin(textField: txtPassword)
    }
    
    func presentModal(){
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let _vc = storyBoard.instantiateViewController(withIdentifier: "UpdateAppViewController") as! UpdateAppViewController
        // _vc.modalPresentationStyle = .currentContext
        self.present(_vc, animated: true, completion: nil)
    }
    
    func estadoRecordarSesion() {
        estadoRecordar = Sesion.shared.estadoSesion()
        let imagen = estadoRecordar ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square")
        btnRecordar.setBackgroundImage(imagen, for: .normal)
        txtCorreo.text = estadoRecordar ? Sesion.shared.correo() : ""
        txtPassword.text = estadoRecordar ? Sesion.shared.clave() : ""
    }
    
    func irAMenu(rol: String) {
        if rol == "Usuario" {
            // Vaciar carrito
            let context = ContextManager.shared.context
            Carrito.eliminarServicios(inContext: context)
            // Ir a Menu de Usuario
            let storyBoard = UIStoryboard(name: "Usuario", bundle: nil)
            let _vc = storyBoard.instantiateViewController(withIdentifier: "UsuarioTBVC") as! UsuarioTabBarViewController
            _vc.selectedIndex = 0
            _vc.modalPresentationStyle = .currentContext
            self.present(_vc, animated: true, completion: nil)
        }
        
        if rol == "Profesional" {
            // Ir a Menu de Profesional
            let storyBoard = UIStoryboard(name: "Profesional", bundle: nil)
            let _vc = storyBoard.instantiateViewController(withIdentifier: "ProfesionalTBVC") as! ProfesionalTabBarViewController
            _vc.selectedIndex = 0
            _vc.modalPresentationStyle = .currentContext
            self.present(_vc, animated: true, completion: nil)
        }
    }
    
    func mostrarAlert(message: String) {
        let alert = UIAlertController(title: "App PeluHome", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert,animated: true)
    }
    
    func validarCampos() -> String? {
        let correoLimpio = txtCorreo.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilitarios.esCorreoValido(correoLimpio) == false {
            txtCorreo = MaterialView.textFieldEstiloInvalido(textField: txtCorreo)
            return "Por favor ingresar un correo valido"
        }
        
        let claveLimpia = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if claveLimpia == "" {
            txtPassword = MaterialView.textFieldEstiloInvalido(textField: txtPassword)
            return "Por favor ingresar su contraseña"
        }
        
        return nil
    }
    
    func animateOut(desiredView:UIView){
        
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            desiredView.alpha = 0
        }, completion: { _ in
            desiredView.removeFromSuperview()
        })
    }
    
    func openAppStore() {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id1550445412"),
           UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:]) { (opened) in
                if(opened){
                    print("App Store Opened")
                }
            }
        } else {
            print("Can't Open URL on Simulator")
        }
    }
}

extension LoginViewController: UpdateAppViewControllerProtocol {
    
    func showErrorMessage() {
        
    }
    
    func reloadUpdateData(_ dataSource: [AplicacionList]) {
        print(dataSource)
    }
    
    
}
