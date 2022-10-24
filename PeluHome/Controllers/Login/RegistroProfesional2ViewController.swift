//
//  RegistroProfesional2ViewController.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 7/12/20.
//

import UIKit

class RegistroProfesional2ViewController: UIViewController {
    
    var usuario = Usuario()
    var categoriasServicios = [CategoriaServicio]()
    var serviciosProfesional = [CategoriaServicio]()
    var mensajeUsuario = ""
    
    @IBOutlet weak var tableViewTodosServicios: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var footerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {  
        ServiciosWeb.obtenerTodosServiciosAPI { (categoriasServiciosAPI) in
            self.categoriasServicios = categoriasServiciosAPI
            self.tableViewTodosServicios.reloadData()
        }
    }
    
    @IBAction func volverAtras(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registrarProfesional(_ sender: UIButton) {
        // Registro de Profesional
        ServiciosWeb.grabarUsuarioAPI(usuario: usuario) { (success, message) in
            if success {
                // Confirmacion de registro de usuario
                let correo = self.usuario.correo
                let clave = self.usuario.clave
                let token = Sesion.shared.token()
                self.mensajeUsuario = message
                self.autenticarCredenciales(correo: correo, clave: clave, token: token)
            } else {
                self.mostrarAlert(message: message)
            }
        }
    }
    
    func autenticarCredenciales(correo: String, clave: String, token: String) {
        ServiciosWeb.autenticarCredencialesAPI(correo: correo, clave: clave, token: token) { (usuario, success, message) in
            if success {
                let idProfesional = usuario.codigo
                self.grabarServiciosProfesional(idProfesional: idProfesional)
            } else {
                self.mostrarAlert(message: message)
            }
        }
    }
    
    func grabarServiciosProfesional(idProfesional: Int) {
        var listaProfesionales = [[String:Any]]()
        
        for servicioProfesional in serviciosProfesional {
            let nuevoProfesional = Profesional()
            nuevoProfesional.idServicio = servicioProfesional.idServicio
            nuevoProfesional.idProfesional = idProfesional
            nuevoProfesional.nombres = usuario.nombres
            nuevoProfesional.apellidos = usuario.apellidos
            nuevoProfesional.profesion = usuario.profesion
            nuevoProfesional.estado = true
            
            let profesional = nuevoProfesional.copiarModeloDiccionario(profesional: nuevoProfesional)
            listaProfesionales.append(profesional)
        }
        
        ServiciosWeb.grabarServiciosProfesionalAPI(idProfesional: idProfesional, listaProfesionales: listaProfesionales) { (success, message) in
            if success {
                // Confirmacion de registro de servicios profesionales
                self.grabarLocalizacion(idProfesional: idProfesional)
            } else {
                self.mostrarAlert(message: message)
            }
        }
    }
    
    func grabarLocalizacion(idProfesional: Int) {
        let localizacion = Localizacion()
        localizacion.idUsuario = idProfesional
        localizacion.latitud = ""
        localizacion.longitud = ""
        localizacion.estadoActivo = false
        
        ServiciosWeb.grabarLocalizacionAPI(localizacion: localizacion) { (success, message) in
            if success {
                // Confirmacion de registro de Localizacion de profesional
                self.mostrarAlertAction(message: "Profesional registrado correctamente")
            } else {
                self.mostrarAlert(message: message)
            }
        }
    }

    func mostrarAlert(message: String) {
        let alert = UIAlertController(title: "App PeluHome", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert,animated: true)
    }
    
    func mostrarAlertAction(message: String) {
        let alert = UIAlertController(title: "App PeluHome", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default) { (action) in
            // Regresar a Login
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(action)
        self.present(alert,animated: true)
    }
    
}

extension RegistroProfesional2ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriasServicios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaCategoriaServicio", for: indexPath)
        let row = indexPath.row
        let categoriaServicio = categoriasServicios[row]
        let nombreServicio = categoriaServicio.nombreServicio
        let estado = categoriaServicio.estado

        cell.textLabel?.text = nombreServicio
        cell.textLabel?.textColor = .systemGray
        cell.imageView?.image = estado ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square")
        cell.imageView?.tintColor = COLOR_PRIMARIO
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 110.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let categoriaServicio = categoriasServicios[row]
        let idServicio = categoriasServicios[row].idServicio
        let estado = categoriasServicios[row].estado
        
        if estado {
            serviciosProfesional.removeAll { (categoriaServicio) -> Bool in
                categoriaServicio.idServicio == idServicio
            }
            categoriasServicios[row].estado = false
        } else {
            serviciosProfesional.append(categoriaServicio)
            categoriasServicios[row].estado = true
        }
        tableView.reloadData()
    }
    
}
