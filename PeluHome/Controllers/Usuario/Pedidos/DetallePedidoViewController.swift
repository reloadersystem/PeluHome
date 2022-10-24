//
//  DetallePedidoViewController.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 11/5/20.
//

import UIKit

class DetallePedidoViewController: UIViewController {
    
    var pedido = Pedido()
    var estrellas = 0.0
    
    @IBOutlet weak var lblProfesional: UILabel!
    @IBOutlet weak var lblDireccion: UILabel!
    @IBOutlet weak var lblMetodoPago: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblHora: UILabel!
    @IBOutlet weak var lblServicios: UILabel!
    @IBOutlet weak var lblObservaciones: UILabel!
    @IBOutlet weak var lblPrecio: UILabel!
    @IBOutlet weak var txtComentarios: UITextField!
    @IBOutlet weak var btnPagar: UIButton!
    @IBOutlet weak var btnAdicionales: UIButton!
    @IBOutlet weak var contenedorCalificacion: UIView!
    @IBOutlet weak var imgEstrella1: UIImageView!
    @IBOutlet weak var imgEstrella2: UIImageView!
    @IBOutlet weak var imgEstrella3: UIImageView!
    @IBOutlet weak var imgEstrella4: UIImageView!
    @IBOutlet weak var imgEstrella5: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurarUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = ContextManager.shared.context
        let detalleAdicional = ServicioAdicional.obtenerDetalleById(id: pedido.idPedido, inContext: context)
        let total = Adicional.shared.total
        let totalPedido = Int(pedido.precio) ?? 0
        let nuevoTotal = total + totalPedido
        lblPrecio.text = "S/ \(nuevoTotal)"

        if Adicional.shared.pagado {
            btnPagar.isHidden = true
        }
        if detalleAdicional != "" {
            btnAdicionales.isHidden = true
        }
    }
    
    @IBAction func pagarServicio(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Usuario", bundle: nil)
        let _vc = storyBoard.instantiateViewController(withIdentifier: "PagoAdicionalVC") as! PagoAdicionalViewController
        _vc.modalPresentationStyle = .currentContext
        _vc.pedido = pedido
        self.navigationController?.pushViewController(_vc, animated: true)
    }
    
    @IBAction func agregarAdicionales(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Usuario", bundle: nil)
        let _vc = storyBoard.instantiateViewController(withIdentifier: "AdicionalesVC") as! EscogerAdicionalesViewController
        _vc.modalPresentationStyle = .currentContext
        _vc.idPedido = pedido.idPedido
        self.navigationController?.pushViewController(_vc, animated: true)
    }
    
    @IBAction func calificacion0P5(_ sender: UIButton) {
        configurarImagenes(puntaje: 0.5)
    }
    
    @IBAction func calificacion1P0(_ sender: UIButton) {
        configurarImagenes(puntaje: 1.0)
    }
    
    @IBAction func calificacion1P5(_ sender: UIButton) {
        configurarImagenes(puntaje: 1.5)
    }
    
    @IBAction func calificacion2P0(_ sender: UIButton) {
        configurarImagenes(puntaje: 2.0)
    }
    
    @IBAction func calificacion2P5(_ sender: UIButton) {
        configurarImagenes(puntaje: 2.5)
    }
    
    @IBAction func calificacion3P0(_ sender: UIButton) {
        configurarImagenes(puntaje: 3.0)
    }
    
    @IBAction func calificacion3P5(_ sender: UIButton) {
        configurarImagenes(puntaje: 3.5)
    }
    
    @IBAction func calificacion4P0(_ sender: UIButton) {
        configurarImagenes(puntaje: 4.0)
    }
    
    @IBAction func calificacion4P5(_ sender: UIButton) {
        configurarImagenes(puntaje: 4.5)
    }
    
    @IBAction func calificacion5P0(_ sender: UIButton) {
        configurarImagenes(puntaje: 5.0)
    }
    
    @IBAction func calificacionServicio(_ sender: UIButton) {
        let idPedido = pedido.idPedido
        let comentarios = txtComentarios.text ?? ""
        
        ServiciosWeb.calificarPedidoAPI(pedido: idPedido, comentarios: comentarios, estrellas: estrellas) { (success, message) in
            if success {
                // Confirmacion de calificacion de Pedido
                self.mostrarAlertAction(message: message)
            } else {
                self.mostrarAlert(message: "No se pudo enviar sus comentarios. Intentelo mas tarde")
            }
        }
    }
    
    func configurarUI() {
        lblProfesional.text = pedido.profesional
        lblDireccion.text = pedido.direccion
        lblMetodoPago.text = pedido.formaPago
        lblFecha.text = pedido.fecha
        let hora = pedido.hora.dropFirst(0).prefix(5) as Substring
        lblHora.text = String(hora)
        let nombreServicios = pedido.servicio
        lblServicios.text = nombreServicios.replacingOccurrences(of: "?", with: ", ")
        lblObservaciones.text = pedido.preferencias
        lblPrecio.text = "S/ \(pedido.precio)"
        txtComentarios.setLeftPaddingPoints(10.0)
        Adicional.shared.pagado = false
        Adicional.shared.total = 0
        
        contenedorCalificacion.isHidden = true
        btnPagar.isHidden = true
        btnAdicionales.isHidden = true

        if (pedido.estado == "Finalizado" && pedido.calificacion == 0) {
            contenedorCalificacion.isHidden = false
            btnPagar.isHidden = false
            btnAdicionales.isHidden = true
        }
        if (pedido.estado == "Pagado" && pedido.calificacion == 0) {
            contenedorCalificacion.isHidden = false
        }
        if pedido.estado == "Finalizado"{
            btnPagar.isHidden = false
            btnAdicionales.isHidden = true
        }
        if pedido.estado == "Aceptado" {
            btnAdicionales.isHidden = false
        }
        if pedido.estado == "Pagado" {
            btnPagar.isHidden = true
        }
    }
    
    func configurarImagenes(puntaje: Double) {
        estrellas = puntaje
        
        switch puntaje {
        case 0.5:
            imgEstrella1.image = UIImage(systemName: "star.fill.left"); imgEstrella1.tintColor = .systemOrange
            imgEstrella2.image = UIImage(systemName: "star"); imgEstrella2.tintColor = .systemGray
            imgEstrella3.image = UIImage(systemName: "star"); imgEstrella3.tintColor = .systemGray
            imgEstrella4.image = UIImage(systemName: "star"); imgEstrella4.tintColor = .systemGray
            imgEstrella5.image = UIImage(systemName: "star"); imgEstrella5.tintColor = .systemGray
        case 1.0:
            imgEstrella1.image = UIImage(systemName: "star.fill"); imgEstrella1.tintColor = .systemOrange
            imgEstrella2.image = UIImage(systemName: "star"); imgEstrella2.tintColor = .systemGray
            imgEstrella3.image = UIImage(systemName: "star"); imgEstrella3.tintColor = .systemGray
            imgEstrella4.image = UIImage(systemName: "star"); imgEstrella4.tintColor = .systemGray
            imgEstrella5.image = UIImage(systemName: "star"); imgEstrella5.tintColor = .systemGray
        case 1.5:
            imgEstrella1.image = UIImage(systemName: "star.fill"); imgEstrella1.tintColor = .systemOrange
            imgEstrella2.image = UIImage(systemName: "star.fill.left"); imgEstrella2.tintColor = .systemOrange
            imgEstrella3.image = UIImage(systemName: "star"); imgEstrella3.tintColor = .systemGray
            imgEstrella4.image = UIImage(systemName: "star"); imgEstrella4.tintColor = .systemGray
            imgEstrella5.image = UIImage(systemName: "star"); imgEstrella5.tintColor = .systemGray
        case 2.0:
            imgEstrella1.image = UIImage(systemName: "star.fill"); imgEstrella1.tintColor = .systemOrange
            imgEstrella2.image = UIImage(systemName: "star.fill"); imgEstrella2.tintColor = .systemOrange
            imgEstrella3.image = UIImage(systemName: "star"); imgEstrella3.tintColor = .systemGray
            imgEstrella4.image = UIImage(systemName: "star"); imgEstrella4.tintColor = .systemGray
            imgEstrella5.image = UIImage(systemName: "star"); imgEstrella5.tintColor = .systemGray
        case 2.5:
            imgEstrella1.image = UIImage(systemName: "star.fill"); imgEstrella1.tintColor = .systemOrange
            imgEstrella2.image = UIImage(systemName: "star.fill"); imgEstrella2.tintColor = .systemOrange
            imgEstrella3.image = UIImage(systemName: "star.fill.left"); imgEstrella3.tintColor = .systemOrange
            imgEstrella4.image = UIImage(systemName: "star"); imgEstrella4.tintColor = .systemGray
            imgEstrella5.image = UIImage(systemName: "star"); imgEstrella5.tintColor = .systemGray
        case 3.0:
            imgEstrella1.image = UIImage(systemName: "star.fill"); imgEstrella1.tintColor = .systemOrange
            imgEstrella2.image = UIImage(systemName: "star.fill"); imgEstrella2.tintColor = .systemOrange
            imgEstrella3.image = UIImage(systemName: "star.fill"); imgEstrella3.tintColor = .systemOrange
            imgEstrella4.image = UIImage(systemName: "star"); imgEstrella4.tintColor = .systemGray
            imgEstrella5.image = UIImage(systemName: "star"); imgEstrella5.tintColor = .systemGray
        case 3.5:
            imgEstrella1.image = UIImage(systemName: "star.fill"); imgEstrella1.tintColor = .systemOrange
            imgEstrella2.image = UIImage(systemName: "star.fill"); imgEstrella2.tintColor = .systemOrange
            imgEstrella3.image = UIImage(systemName: "star.fill"); imgEstrella3.tintColor = .systemOrange
            imgEstrella4.image = UIImage(systemName: "star.fill.left"); imgEstrella4.tintColor = .systemOrange
            imgEstrella5.image = UIImage(systemName: "star"); imgEstrella5.tintColor = .systemGray
        case 4.0:
            imgEstrella1.image = UIImage(systemName: "star.fill"); imgEstrella1.tintColor = .systemOrange
            imgEstrella2.image = UIImage(systemName: "star.fill"); imgEstrella2.tintColor = .systemOrange
            imgEstrella3.image = UIImage(systemName: "star.fill"); imgEstrella3.tintColor = .systemOrange
            imgEstrella4.image = UIImage(systemName: "star.fill"); imgEstrella4.tintColor = .systemOrange
            imgEstrella5.image = UIImage(systemName: "star"); imgEstrella5.tintColor = .systemGray
        case 4.5:
            imgEstrella1.image = UIImage(systemName: "star.fill"); imgEstrella1.tintColor = .systemOrange
            imgEstrella2.image = UIImage(systemName: "star.fill"); imgEstrella2.tintColor = .systemOrange
            imgEstrella3.image = UIImage(systemName: "star.fill"); imgEstrella3.tintColor = .systemOrange
            imgEstrella4.image = UIImage(systemName: "star.fill"); imgEstrella4.tintColor = .systemOrange
            imgEstrella5.image = UIImage(systemName: "star.fill.left"); imgEstrella5.tintColor = .systemOrange
        case 5.0:
            imgEstrella1.image = UIImage(systemName: "star.fill"); imgEstrella1.tintColor = .systemOrange
            imgEstrella2.image = UIImage(systemName: "star.fill"); imgEstrella2.tintColor = .systemOrange
            imgEstrella3.image = UIImage(systemName: "star.fill"); imgEstrella3.tintColor = .systemOrange
            imgEstrella4.image = UIImage(systemName: "star.fill"); imgEstrella4.tintColor = .systemOrange
            imgEstrella5.image = UIImage(systemName: "star.fill"); imgEstrella5.tintColor = .systemOrange
        default:
            print("")
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
            self.contenedorCalificacion.isHidden = true
            // Regresar a Pedidos
            //self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        self.present(alert,animated: true)
    }
    
}
