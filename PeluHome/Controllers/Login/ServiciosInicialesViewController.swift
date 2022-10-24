//
//  ServiciosInicialesViewController.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 25/02/21.
//

import UIKit
import Alamofire
import AlamofireImage

class ServiciosInicialesViewController: UIViewController {

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
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        ServiciosWeb.obtenerServiciosAPI(idCategoria: idCategoria) { (serviciosAPI) in
            self.servicios = serviciosAPI
            self.tableViewServicios.reloadData()
        }
    }
    
    @IBAction func volverALogin(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension ServiciosInicialesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servicios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaServicioInicial", for: indexPath) as! ServiciosInicialesTableViewCell
        let row = indexPath.row
        let servicio = servicios[row]
        let nombre = servicio.nombreServicio
        let precio = servicio.precio
        
        cell.lblServicio.text = nombre
        cell.lblPrecio.text = "S/ \(precio)"
        
        return cell
    }
    
}
