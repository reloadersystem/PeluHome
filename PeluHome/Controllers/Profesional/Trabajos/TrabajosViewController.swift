//
//  TrabajosViewController.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 2/12/20.
//

import UIKit

class TrabajosViewController: UIViewController {

    var pedidos = [Pedido]()
    
    @IBOutlet weak var tableViewTrabajos: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        let rol = 2
        let idUsuario = Sesion.shared.codigo()

        ServiciosWeb.obtenerPedidosAPI(idUsuario: idUsuario, rol: rol) { (pedidosAPI) in
            self.pedidos = pedidosAPI
            self.tableViewTrabajos.reloadData()
        }
    }

    @IBAction func verDetalle(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Profesional", bundle: nil)
        let _vc = storyBoard.instantiateViewController(withIdentifier: "DetalleTrabajoVC") as! DetalleTrabajoViewController
        _vc.modalPresentationStyle = .currentContext
        _vc.pedido = pedidos[sender.tag]
        self.navigationController?.pushViewController(_vc, animated: true)
    }

}

extension TrabajosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pedidos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaTrabajo", for: indexPath) as! TrabajoTableViewCell
        let row = indexPath.row
        let pedido = pedidos[row]
        let nombreServicios = pedido.servicio
        let cliente = pedido.usuario
        let direccion = pedido.direccion
        let metodoPago = pedido.formaPago
        let fecha = pedido.fecha
        let hora = pedido.hora.dropFirst(0).prefix(5) as Substring
        let estado = pedido.estado
        let servicios = nombreServicios.replacingOccurrences(of: "?", with: ", ")
        
        cell.lblServicios.text = servicios
        cell.lblCliente.text = cliente
        cell.lblDireccion.text = direccion
        cell.lblMetodoPago.text = metodoPago
        cell.lblFecha.text = fecha
        cell.lblHora.text = String(hora)
        cell.lblEstado.text = estado.uppercased()

        cell.btnDetalle.tag = row
        cell.btnDetalle.addTarget(self, action: #selector(verDetalle), for: .touchUpInside)

        return cell
    }
    
}
