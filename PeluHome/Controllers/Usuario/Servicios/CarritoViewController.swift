//
//  CarritoViewController.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 11/1/20.
//

import UIKit
import Alamofire
import AlamofireImage

class CarritoViewController: UIViewController {
    
    var carrito = [Carrito]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configurarUI()
    }
    
    func configurarUI() {
        // Configurar Navigation Bar
        title = "Servicios seleccionados"
        let backButton = UIBarButtonItem()
        backButton.title = "Pedido"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        // Configurar UI
        let context = ContextManager.shared.context
        carrito = Carrito.listarServicios(inContext: context)
    }

}

extension CarritoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carrito.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaCarrito", for: indexPath) as! CarritoTableViewCell
        let row = indexPath.row
        let servicio = carrito[row]
        let nombreServicio = servicio.nombreServicio ?? ""
        let urlImagen = servicio.rutaImagen ?? ""
        let cantidad = servicio.cantidad
        let precioFinal = servicio.precioFinal
        
        cell.lblServicioCantidad.text = "\(nombreServicio) (\(cantidad))"
        cell.lblPrecio.text = "S/ \(precioFinal).00"
        
        AF.request(urlImagen, method: .get).response { response in
            guard let data = response.data, let image = UIImage(data:data) else { return }
            let imageData = image.jpegData(compressionQuality: 1.0)
            cell.imgServicio.image = UIImage(data : imageData!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    
}
