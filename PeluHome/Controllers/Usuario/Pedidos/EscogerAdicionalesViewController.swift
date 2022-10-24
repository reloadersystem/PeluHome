//
//  EscogerAdicionalesViewController.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 27/01/21.
//

import UIKit

class EscogerAdicionalesViewController: UIViewController {
    
    var servicios = [Servicio]()
    var adicionales = [Adicionales]()
    var idPedido = 0
    var serviciosAdicionales = ""
    
    @IBOutlet weak var tableViewServicios: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var btnAdicionar: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurarUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ServiciosWeb.obtenerServiciosAdicionalesAPI() { (serviciosAPI) in
            self.servicios = serviciosAPI
            self.tableViewServicios.reloadData()
        }
    }
    
    @IBAction func adicionarServicios(_ sender: UIButton) {
        serviciosAdicionales = prepararAdicionales()

        ServiciosWeb.actualizarServiciosAdicionalesAPI(codigo: idPedido, serviciosAdicionales: serviciosAdicionales) { (success, message) in
            if success {
                // Confirmacion de servicios adicionales agregados
                self.mostrarAlertAction(message: message)
            } else {
                self.mostrarAlert(message: message)
            }
        }
    }
    
    @IBAction func sumar(_ sender: UIButton) {
        let context = ContextManager.shared.context
        let idServicio = String(servicios[sender.tag].idServicio)
        let servicio = Servicio.obtenerServicioById(idServicio: idServicio, servicios: servicios)
        let cantidad = Adicionales.cantidadById(id: idPedido, idServicio: idServicio, inContext: context)
        let cant = cantidad < 100 ? cantidad + 1 : 100
        let nuevoServicio = Adicionales.agregarServicio(id: idPedido, idServicio: idServicio, inContext: context)
        nuevoServicio.copy(id:idPedido, servicio: servicio, cant: cant)
        try? context.save()
        tableViewServicios.reloadData()
    }
    
    @IBAction func restar(_ sender: UIButton) {
        let context = ContextManager.shared.context
        let idServicio = String(servicios[sender.tag].idServicio)
        let servicio = Servicio.obtenerServicioById(idServicio: idServicio, servicios: servicios)
        let cantidad = Adicionales.cantidadById(id: idPedido, idServicio: idServicio, inContext: context)
        let cant = cantidad > 0 ? cantidad - 1 : 0
        if cant == 0 {
            Adicionales.eliminarServicioById(id: idPedido, idServicio: idServicio, inContext: context)
        } else {
            let nuevoServicio = Adicionales.agregarServicio(id: idPedido, idServicio: idServicio, inContext: context)
            nuevoServicio.copy(id:idPedido, servicio: servicio, cant: cant)
            try? context.save()
        }
        
        tableViewServicios.reloadData()
    }
    
    func configurarUI() {
        // Configurar Navigation Bar
        title = "Servicios adicionales"
        let backButton = UIBarButtonItem()
        backButton.title = "Detalle"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        // Configurar UI
        btnAdicionar.backgroundColor = COLOR_PRIMARIO
    }
    
    func prepararAdicionales() -> String {
        let context = ContextManager.shared.context
        adicionales = Adicionales.listasAdicionalesById(id: idPedido, inContext: context)
        var serviciosAdicionales = ""
        let contador = adicionales.count
        
        if contador == 0 {
            mostrarAlert(message: "Debe agregar al menos un servicio")
        }
        
        for i in 0...contador-1 {
            let servicioAdicional = adicionales[i].servicioAdicional ?? ""
            
            if servicioAdicional != "" {
                let campos = servicioAdicional.split(separator: "|")
                let codigo = String(campos[0])
                let precio = String(campos[1])
                let cantidad = String(campos[2])
                
                if i == 0 {
                    serviciosAdicionales = serviciosAdicionales + codigo + "-" + precio + "-" + cantidad
                }
                else{
                    serviciosAdicionales = serviciosAdicionales + "|" + codigo + "-" + precio + "-" + cantidad
                }
            }
        }
        
        return serviciosAdicionales
    }
    
    func mostrarAlert(message: String) {
        let alert = UIAlertController(title: "App PeluHome", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert,animated: true)
    }
    
    func mostrarAlertAction(message: String) {
        let alert = UIAlertController(title: "App PeluHome", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Continuar", style: .default) { (action) in
            // Contexto
            let context = ContextManager.shared.context
            // Obtener total y guardarlo
            let total = Adicionales.calcularTotalById(id: self.idPedido, inContext: context)
            Adicional.shared.total = Int(total)
            // Guardar en Coredata datos de servicio adicional
            let nuevoAdicional = ServicioAdicional.agregarServicio(id: self.idPedido, inContext: context)
            nuevoAdicional.copy(id: self.idPedido, tot: total, servicios: self.serviciosAdicionales)
            try? context.save()
            // Vaciar carrito de adicionales
            Adicionales.eliminarServiciosById(id: self.idPedido, inContext: context)
            // Regresar a Detalle de Pedido
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        self.present(alert,animated: true)
    }

}

extension EscogerAdicionalesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servicios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaServicioAdicional", for: indexPath) as! ServiciosAdicionalesTableViewCell
        
        let row = indexPath.row
        let servicio = servicios[row]
        let nombre = servicio.nombreServicio
        let precio = servicio.precio
        let idServicio = String(servicio.idServicio)
        
        let context = ContextManager.shared.context
        let cantidad = Adicionales.cantidadById(id: idPedido, idServicio: idServicio, inContext: context)
        
        cell.lblServicio.text = nombre
        cell.lblPrecio.text = "S/ \(precio)"
        cell.lblCantidad.text = "\(cantidad)"
        
        cell.btnSumar.tag = row
        cell.btnSumar.addTarget(self, action: #selector(sumar), for: .touchUpInside)
        
        cell.btnRestar.tag = row
        cell.btnRestar.addTarget(self, action: #selector(restar), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80.0
    }
    
}
