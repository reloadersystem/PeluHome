//
//  DetalleTrabajoViewController.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 2/12/20.
//

import UIKit

class DetalleTrabajoViewController: UIViewController {
    
    var pedido = Pedido()
    
    @IBOutlet weak var lblCliente: UILabel!
    @IBOutlet weak var lblDireccion: UILabel!
    @IBOutlet weak var lblMetodoPago: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblHora: UILabel!
    @IBOutlet weak var lblServicios: UILabel!
    @IBOutlet weak var lblObservaciones: UILabel!
    @IBOutlet weak var lblPrecio: UILabel!
    @IBOutlet weak var lblMensajeAceptarRechazar: UILabel!
    @IBOutlet weak var btnAceptar: UIButton!
    @IBOutlet weak var btnRechazar: UIButton!
    @IBOutlet weak var btnFinalizar: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurarUI()
        configurarBotones()
    }
    
    @IBAction func aceptarPedido(_ sender: UIButton) {
        actualizarPedido(estado: "Aceptado")
    }
    
    @IBAction func rechazarPedido(_ sender: UIButton) {
        actualizarPedido(estado: "Rechazado")
    }
    
    @IBAction func finalizarPedido(_ sender: UIButton) {
        actualizarPedido(estado: "Finalizado")
    }
    
    func configurarUI() {
        lblCliente.text = pedido.usuario
        lblDireccion.text = pedido.direccion
        lblMetodoPago.text = pedido.formaPago
        lblFecha.text = pedido.fecha
        let hora = pedido.hora.dropFirst(0).prefix(5) as Substring
        lblHora.text = String(hora)
        let nombreServicios = pedido.servicio
        lblServicios.text = nombreServicios.replacingOccurrences(of: "?", with: ", ")
        lblObservaciones.text = pedido.preferencias
        lblPrecio.text = "S/ \(pedido.precio)"
    }
    
    func configurarBotones() {
        switch pedido.estado {
        case "Agendado":
            btnAceptar.isHidden = false
            btnRechazar.isHidden = false
            btnFinalizar.isHidden = true
            lblMensajeAceptarRechazar.isHidden = false
            lblMensajeAceptarRechazar.text = "Estimada Profesional antes de rechazar algún servicio, comunícate con Peluhome al 923301588 - 996286065 / contacto@peluhome.com"
        case "Aceptado", "Rechazado":
            btnAceptar.isHidden = true
            btnRechazar.isHidden = true
            btnFinalizar.isHidden = false
            lblMensajeAceptarRechazar.isHidden = false
            lblMensajeAceptarRechazar.text = "Por favor, asegúrate que el cliente no tiene ningún adicional que incluir antes de finalizar el servicio."
        default:
            btnAceptar.isHidden = true
            btnRechazar.isHidden = true
            btnFinalizar.isHidden = true
            lblMensajeAceptarRechazar.isHidden = true
        }
    }
    
    func actualizarPedido(estado: String) {
        pedido.estado = estado
        ServiciosWeb.actualizarPedidoAPI(pedido: pedido) { (success, message) in
            if success {
                switch estado {
                    case "Aceptado":
                        self.mostrarAlert(message: "Pedido \(estado)")
                    case "Rechazado":
                        self.actualizarEstadoTomado(estado: estado)
                    case "Finalizado":
                        self.actualizarEstadoTomado(estado: estado)
                    default:
                        print("Estado no definido")
                }
            } else {
                self.mostrarAlert(message: message)
            }
        }
    }
    
    func actualizarEstadoTomado(estado: String) {
        let codigo = Sesion.shared.codigo()
        let localizacion = Localizacion()
        localizacion.idUsuario = codigo
        localizacion.latitud = ""
        localizacion.longitud = ""
        localizacion.estadoTomado = false
        
        ServiciosWeb.actualizarEstadoTomadoAPI(localizacion: localizacion) { (success, message) in
            if success {
                switch estado {
                    case "Rechazado":
                        self.mostrarAlert(message: "Pedido \(estado)")
                    case "Finalizado":
                        self.mostrarAlert(message: "Pedido \(estado)")
                    default:
                        print("Estado no definido")
                }
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
    
}
