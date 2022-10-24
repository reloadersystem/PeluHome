//
//  ServiciosViewController.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 10/18/20.
//

import UIKit
import Alamofire
import AlamofireImage

class ServiciosViewController: UIViewController {
    
    var servicios = [Servicio]()
    var idCategoria = 0
    var nombreCategoria = ""
    
    @IBOutlet weak var tableViewServicios: UITableView!
    @IBOutlet weak var btnReservar: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = nombreCategoria
        btnReservar.backgroundColor = COLOR_PRIMARIO
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        
        ServiciosWeb.obtenerServiciosAPI(idCategoria: idCategoria) { (serviciosAPI) in
            self.servicios = serviciosAPI
            self.tableViewServicios.reloadData()
        }
    }
    
    @IBAction func sumar(_ sender: UIButton) {
        let context = ContextManager.shared.context
        let idServicio = String(servicios[sender.tag].idServicio)
        let servicio = Servicio.obtenerServicioById(idServicio: idServicio, servicios: servicios)
        let cantidad = Carrito.cantidadById(idServicio: idServicio, inContext: context)
        let cant = cantidad < 100 ? cantidad + 1 : 100
        let nuevoServicio = Carrito.agregarServicio(idServicio: idServicio, inContext: context)
        nuevoServicio.copy(servicio: servicio, cant: cant)
        try? context.save()
        tableViewServicios.reloadData()
    }
    
    @IBAction func restar(_ sender: UIButton) {
        let context = ContextManager.shared.context
        let idServicio = String(servicios[sender.tag].idServicio)
        let servicio = Servicio.obtenerServicioById(idServicio: idServicio, servicios: servicios)
        let cantidad = Carrito.cantidadById(idServicio: idServicio, inContext: context)
        let cant = cantidad > 0 ? cantidad - 1 : 0
        if cant == 0 {
            Carrito.eliminarServicio(idServicio: idServicio, inContext: context)
        } else {
            let nuevoServicio = Carrito.agregarServicio(idServicio: idServicio, inContext: context)
            nuevoServicio.copy(servicio: servicio, cant: cant)
            try? context.save()
        }
        
        tableViewServicios.reloadData()
    }

}

extension ServiciosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servicios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaServicio", for: indexPath) as! ServiciosTableViewCell
        let row = indexPath.row
        let servicio = servicios[row]
        let nombre = servicio.nombreServicio
        let precio = servicio.precio
        //let urlImagen = servicio.rutaImagen
        let idServicio = String(servicio.idServicio)
        
        let context = ContextManager.shared.context
        let cantidad = Carrito.cantidadById(idServicio: idServicio, inContext: context)
        
        cell.lblServicio.text = nombre
        cell.lblPrecio.text = "S/ \(precio)"
        cell.lblCantidad.text = "\(cantidad)"
        
//        AF.request(urlImagen, method: .get).response { response in
//            guard let data = response.data, let image = UIImage(data:data) else { return }
//            let imageData = image.jpegData(compressionQuality: 1.0)
//            cell.imgServicio.image = UIImage(data : imageData!)
//        }
        
        cell.btnSumar.tag = row
        cell.btnSumar.addTarget(self, action: #selector(sumar), for: .touchUpInside)
        
        cell.btnRestar.tag = row
        cell.btnRestar.addTarget(self, action: #selector(restar), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
    
}
