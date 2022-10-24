//
//  MetodoPagoViewController.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 11/2/20.
//

import UIKit

class MetodoPagoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var miControladorImagen: UIImagePickerController!
    var guardaImagen: UIImage?
    var metodoPago = "efectivo"
    var imagen = ""
    
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
        Programado.shared.formaPago = metodoPago
        Inmediato.shared.formaPago = metodoPago
        self.navigationController?.popViewController(animated: true)
        
        if metodoPago == "deposito" {
            guard let imagen = guardaImagen else { return }
            //UIImageWriteToSavedPhotosAlbum(imagen, nil, nil, nil)
            Programado.shared.imagenDeposito = convertImageToBase64String(img: imagen)
            Inmediato.shared.imagenDeposito = convertImageToBase64String(img: imagen)
        }
    }
    
    func configurarUI() {
        // Configurar Navigation Bar
        title = "Metodo de pago"
        let backButton = UIBarButtonItem()
        backButton.title = "Pedido"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        // Configurar UI
        contenedorDeposito.isHidden = true
        btnTomarFoto.isHidden = true
        btnGaleria.isHidden = true
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
