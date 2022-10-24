//
//  PerfilProfesionalViewController.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 3/12/20.
//

import UIKit
import Alamofire
import AlamofireImage
import CoreLocation

class PerfilProfesionalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    var usuario = Usuario()
    var miControladorImagen: UIImagePickerController!
    var guardaImagen: UIImage?
    var disponibilidad = 0
    var localizacionActiva = false
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var txtNombres: UITextField!
    @IBOutlet weak var txtApellidos: UITextField!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtCelular: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtDireccion: UITextField!
    @IBOutlet weak var lblNombres: UILabel!
    @IBOutlet weak var lblApellidos: UILabel!
    @IBOutlet weak var imgUsuario: UIImageView!
    @IBOutlet weak var swLocalizacion: UISwitch!
    @IBOutlet weak var swDisponibilidad: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let codigo = Sesion.shared.codigo()
        ServiciosWeb.obtenerDatosPersonalesAPI(codigo: codigo) { (usuario) in
            self.usuario = usuario
            self.configurarUI(usuario: usuario)
        }
    }
    
    @IBAction func cambiarImagen(_ sender: Any) {
        miControladorImagen = UIImagePickerController()
        miControladorImagen.delegate = self
        miControladorImagen.sourceType = .camera
        present(miControladorImagen, animated: true, completion: nil)
    }
    
    @IBAction func activarLocalizacion(_ sender: UISwitch) {
        if sender.isOn {
            // Localizacion
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                locationManager.startUpdatingLocation()
                locationManager.allowsBackgroundLocationUpdates = true
            }
        } else {
            locationManager.stopUpdatingLocation()
            let codigo = Sesion.shared.codigo()
            let localizacion = Localizacion()
            localizacion.idUsuario = codigo
            localizacion.latitud = ""
            localizacion.longitud = ""
            localizacion.estadoActivo = false
            actualizarLocalizacion(localizacion: localizacion)
        }
    }
    
    @IBAction func activarDisponibilidad(_ sender: UISwitch) {
        let estado = sender.isOn ? 1 : 0
        let codigo = Sesion.shared.codigo()
        ServiciosWeb.actualizarDisponibilidadAPI(codigo: codigo, estado: estado) { (success, message) in
            if success {
                self.disponibilidad = sender.isOn ? 1 : 0
                if self.disponibilidad == 1 {
                    self.mostrarAlert(message: message)
                }
            } else {
                self.mostrarAlert(message: message)
                self.swDisponibilidad.isOn = self.disponibilidad == 1 ? true : false
            }
        }
    }
    
    @IBAction func actualizarProfesional(_ sender: UIButton) {
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
        swDisponibilidad.isOn = usuario.disponible == 1 ? true : false
        swLocalizacion.isOn = usuario.estadoActivo
        disponibilidad = usuario.disponible
        localizacionActiva = usuario.estadoActivo
        
        let urlImagen = usuario.imagen
        
        AF.request(urlImagen, method: .get).response { response in
            guard let data = response.data, let image = UIImage(data:data) else { return }
            let imageData = image.jpegData(compressionQuality: 1.0)
            self.imgUsuario.image = UIImage(data : imageData!)
        }
    }
    
    func actualizarLocalizacion(localizacion: Localizacion) {
        ServiciosWeb.actualizarLocalizacionAPI(localizacion: localizacion) { (success, message) in
            if success {
                self.localizacionActiva = self.swDisponibilidad.isOn
                let latitud = localizacion.latitud
                let longitud = localizacion.longitud
                print("localizacion = \(latitud) \(longitud)")
            } else {
                self.mostrarAlert(message: message)
                self.swDisponibilidad.isOn = self.localizacionActiva
            }
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
        let imageData:NSData = img.jpegData(compressionQuality: 0.50)! as NSData
        let imgString = imageData.base64EncodedString(options: .init(rawValue: 0))
        return imgString
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //print("locations = \(latitud) \(longitud)")
        let latitud = location.latitude
        let longitud = location.longitude
        let codigo = Sesion.shared.codigo()
        let localizacion = Localizacion()
        localizacion.idUsuario = codigo
        localizacion.latitud = "\(latitud)"
        localizacion.longitud = "\(longitud)"
        localizacion.estadoActivo = true
        actualizarLocalizacion(localizacion: localizacion)
    }
    
}
