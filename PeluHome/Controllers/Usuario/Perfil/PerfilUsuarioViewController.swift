//
//  PerfilUsuarioViewController.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 3/12/20.
//

import UIKit
import Alamofire
import AlamofireImage

class PerfilUsuarioViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var usuario = Usuario()
    var miControladorImagen: UIImagePickerController!
    var guardaImagen: UIImage?
    
    @IBOutlet weak var txtNombres: UITextField!
    @IBOutlet weak var txtApellidos: UITextField!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtCelular: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtDireccion: UITextField!
    @IBOutlet weak var lblNombres: UILabel!
    @IBOutlet weak var lblApellidos: UILabel!
    @IBOutlet weak var imgUsuario: UIImageView!
    
    var codeUser:Int = 0
    
    lazy private var presenter = PerfilUsuarioPresenter(controller: self)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let codigo = Sesion.shared.codigo()
        ServiciosWeb.obtenerDatosPersonalesAPI(codigo: codigo) { (usuario) in
            self.usuario = usuario
            self.codeUser = usuario.codigo
           
            self.configurarUI(usuario: usuario)
        }
    }
    
    @IBAction func cambiarImagen(_ sender: Any) {
        miControladorImagen = UIImagePickerController()
        miControladorImagen.delegate = self
        miControladorImagen.sourceType = .camera
        present(miControladorImagen, animated: true, completion: nil)
    }
    
    
    @IBAction func deleteUserButton(_ sender: Any) {
        print(self.codeUser)
        self.presenter.doDeleteAppWithUser(user: 219)
    }
    
    @IBAction func actualizarUsuario(_ sender: UIButton) {
        usuario.nombres = txtNombres.text ?? ""
        usuario.apellidos = txtApellidos.text ?? ""
        usuario.celular = txtCelular.text ?? ""
        usuario.clave = txtPassword.text ?? ""
        usuario.direccion = txtDireccion.text ?? ""
        if guardaImagen != nil {
            usuario.imagen = convertImageToBase64String(img: guardaImagen!)
        }
        
        ServiciosWeb.actualizarUsuarioAPI(usuario: usuario) { (success, message) in
            self.mostrarAlert(message: message)
        }
    }
    
    @IBAction func irALogin(_ sender: UIButton) {
        tabBarController?.tabBar.isHidden = true
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let _vc = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
        _vc.modalPresentationStyle = .currentContext
        self.present(_vc, animated: true, completion: nil)
    }
    
    func configurarUI(usuario: Usuario){
        txtNombres.text = usuario.nombres
        txtApellidos.text = usuario.apellidos
        txtCorreo.placeholder = usuario.correo
        txtCelular.text = usuario.celular
        txtPassword.text = usuario.clave
        txtDireccion.text = usuario.direccion
        lblNombres.text = usuario.nombres
        lblApellidos.text = usuario.apellidos
        let urlImagen = usuario.imagen
        
        AF.request(urlImagen, method: .get).response { response in
            guard let data = response.data, let image = UIImage(data:data) else { return }
            let imageData = image.jpegData(compressionQuality: 1.0)
            self.imgUsuario.image = UIImage(data : imageData!)
        }
    }
    
    func mostrarAlert(message: String) {
        let alert = UIAlertController(title: "App PeluHome", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //var guardaImagen: UIImage?
        miControladorImagen.dismiss(animated: true, completion: nil)
        imgUsuario.image = info[.originalImage] as? UIImage
        guardaImagen = info[.originalImage] as? UIImage
        //UIImageWriteToSavedPhotosAlbum(guardaImagen!, nil, nil, nil)
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        let imageData:NSData = img.jpegData(compressionQuality: 0.50)! as NSData //UIImagePNGRepresentation(img)
        let imgString = imageData.base64EncodedString(options: .init(rawValue: 0))
        return imgString
    }

}

extension PerfilUsuarioViewController: DeleteUserViewControllerProtocol{
    
    
    func showErrorMessage() {
        
    }
    
    func reloadDeleteData(_ dataSource: DeleteUserResponse) {
        print(dataSource)
        
    }
}
