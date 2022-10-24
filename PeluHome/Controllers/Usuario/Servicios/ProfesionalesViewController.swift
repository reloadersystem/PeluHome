//
//  ProfesionalesViewController.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 11/2/20.
//

import UIKit
import Alamofire
import AlamofireImage

protocol ProfesionalesDelegate {
    func profesionalSeleccionado(profesional: Profesional)
}

class ProfesionalesViewController: UIViewController {
    
    var profesionales = [Profesional]()
    var numeroServicios = 0
    var profesionalesDelegate: ProfesionalesDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurarUI()
    }
    
    func configurarUI() {
        // Configurar Navigation Bar
        title = "Profesionales"
        let backButton = UIBarButtonItem()
        backButton.title = "Pedido"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
}

extension ProfesionalesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profesionales.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaProfesional", for: indexPath) as! ProfesionalesTableViewCell
        let row = indexPath.row
        let profesional = profesionales[row]
        let nombre = profesional.nombres
        let urlImagen = profesional.imagen
        let profesion = profesional.profesion
        let nombreServicios = profesional.nombreServicio
        let calificacion = profesional.calificacion
        let servicios = nombreServicios.replacingOccurrences(of: "?", with: ", ")
        
        cell.lblNombre.text = nombre
        cell.lblProfesion.text = profesion.isEmpty ? "Profesion" : profesion
        cell.lblServicios.text = servicios
        cell.configurarImagenes(puntaje: calificacion)
        
        AF.request(urlImagen, method: .get).response { response in
            guard let data = response.data, let image = UIImage(data:data) else { return }
            let imageData = image.jpegData(compressionQuality: 1.0)
            cell.imgProfesional.image = UIImage(data : imageData!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profesional = profesionales[indexPath.row]
        profesionalesDelegate.profesionalSeleccionado(profesional: profesional)
    }
    
}
