//
//  PagoAdicionalViewController.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 28/01/21.
//

import UIKit

class PagoAdicionalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var miControladorImagen: UIImagePickerController!
    var guardaImagen: UIImage?
    var metodoPago = "efectivo"
    var pedido = Pedido()
    var imagenDeposito = ""
    
    @IBOutlet weak var btnEfectivo: UIButton!
    @IBOutlet weak var btnDeposito: UIButton!
    @IBOutlet weak var btnTomarFoto: UIButton!
    @IBOutlet weak var btnGaleria: UIButton!
    @IBOutlet weak var contenedorDeposito: UIView!
    @IBOutlet weak var imgDeposito: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurarUI()
    }
    
    @IBAction func seleccionarMetodoPago(_ sender: UIButton) {
        contenedorDeposito.isHidden = sender != btnDeposito
        btnTomarFoto.isHidden = sender != btnDeposito
        btnGaleria.isHidden = sender != btnDeposito
        let imgEfectivo = sender == btnEfectivo ? UIImage(systemName: "largecircle.fill.circle") : UIImage(systemName: "circle")
        let imgDeposito = sender == btnDeposito ? UIImage(systemName: "largecircle.fill.circle") : UIImage(systemName: "circle")
        btnEfectivo.setImage(imgEfectivo, for: .normal)
        btnEfectivo.tintColor = sender == btnEfectivo ? COLOR_ACCENT : .darkGray
        btnDeposito.setImage(imgDeposito, for: .normal)
        btnDeposito.tintColor = sender == btnDeposito ? COLOR_ACCENT : .darkGray
        metodoPago = sender == btnDeposito ? "deposito" : "efectivo"
    }
    
    @IBAction func tomarFoto(_ sender: Any) {
        miControladorImagen = UIImagePickerController()
        miControladorImagen.delegate = self
        miControladorImagen.sourceType = .camera
        present(miControladorImagen, animated: true, completion: nil)
    }
    
    @IBAction func seleccionarGaleria(_ sender: Any) {
        miControladorImagen = UIImagePickerController()
        miControladorImagen.delegate = self
        miControladorImagen.sourceType = .photoLibrary
        present(miControladorImagen, animated: true, completion: nil)
    }
    
    @IBAction func aceptarMetodoPago(_ sender: Any) {
        if metodoPago == "deposito" {
            guard let imagen = guardaImagen else { return }
            //UIImageWriteToSavedPhotosAlbum(imagen, nil, nil, nil)
            imagenDeposito = convertImageToBase64String(img: imagen)
        }
        actualizarPago()
    }

    func configurarUI() {
        // Configurar Navigation Bar
        title = "Metodo de pago"
        let backButton = UIBarButtonItem()
        backButton.title = "Detalle"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        // Configurar UI
        contenedorDeposito.isHidden = true
        btnTomarFoto.isHidden = true
        btnGaleria.isHidden = true
    }
    
    func actualizarPago() {
        ServiciosWeb.actualizarPagoAPI(codigo: pedido.idPedido, imagen: imagenDeposito, tipoPago: metodoPago) { (success, message) in
            if success {
                Adicional.shared.pagado = true
                self.actualizarPedido(estado: "Pagado")
            } else {
                self.mostrarAlert(message: message)
            }
        }
    }
    
    func actualizarPedido(estado: String) {
        pedido.estado = estado
        ServiciosWeb.actualizarPedidoAPI(pedido: pedido) { (success, message) in
            if success{
                self.navigationController?.popViewController(animated: true)
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        miControladorImagen.dismiss(animated: true, completion: nil)
        imgDeposito.image = info[.originalImage] as? UIImage
        guardaImagen = info[.originalImage] as? UIImage
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        let imageData:NSData = img.jpegData(compressionQuality: 0.50)! as NSData
        let imgString = imageData.base64EncodedString(options: .init(rawValue: 0))
        return imgString
    }

}
