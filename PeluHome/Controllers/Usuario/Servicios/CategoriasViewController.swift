//
//  CategoriasViewController.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 10/18/20.
//

import UIKit
import Alamofire
import AlamofireImage

class CategoriasViewController: UIViewController {
    
    var categorias = [Categoria]()
    
    @IBOutlet weak var tableViewCategorias: UITableView!
    @IBOutlet weak var headerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        
        ServiciosWeb.obtenerCategoriasAPI { (categoriasAPI) in
            self.categorias = categoriasAPI
            self.tableViewCategorias.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueServicio" {
            if let indexPath = tableViewCategorias.indexPathForSelectedRow {
                let categoriaSelected = categorias[indexPath.row]
                let idCategoria = categoriaSelected.idCategoria
                let nombreCategoria = categoriaSelected.nombre
                let objDestino = segue.destination as! ServiciosViewController
                objDestino.idCategoria = idCategoria
                objDestino.nombreCategoria = nombreCategoria
            }
        }
    }
    
    
   

}

extension CategoriasViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaCategoria", for: indexPath) as! CategoriasTableViewCell
        let row = indexPath.row
        let categoria = categorias[row]
        let nombre = categoria.nombre
        let urlImagen = categoria.rutaImagen
        
        cell.lblCategoria.text = nombre
        
        AF.request(urlImagen, method: .get).response { response in
            guard let data = response.data, let image = UIImage(data:data) else { return }
            let imageData = image.jpegData(compressionQuality: 1.0)
            cell.imgCategoria.image = UIImage(data : imageData!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
}
