//
//  MetodoPagoViewController.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 11/2/20.
//

import UIKit

class MetodoPagoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var btnEfectivos: UIButton!
    @IBOutlet weak var btnDepositos: UIButton!
    @IBOutlet weak var btnGalerias: UIButton!
    @IBOutlet weak var contenedorDepositos: UIView!
    @IBOutlet weak var imgDepositos: UIImageView!
    @IBOutlet weak var btnTomarFotos: UIButton!
    
    var miControladorImagen: UIImagePickerController!
    var guardaImagen: UIImage?
    var metodoPago = "efectivo"
    var imagen = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurarUI()
    }

    
    @IBAction func metodoPagoSelected(_ sender: UIButton) {
        contenedorDepositos.isHidden = sender != btnDepositos
        btnTomarFotos.isHidden = sender != btnDepositos
        btnGalerias.isHidden = sender != btnDepositos
        let imgEfectivo = sender == btnEfectivos ? UIImage(systemName: "largecircle.fill.circle") : UIImage(systemName: "circle")
        let imgDeposito = sender == btnDepositos ? UIImage(systemName: "largecircle.fill.circle") : UIImage(systemName: "circle")
        btnEfectivos.setImage(imgEfectivo, for: .normal)
        btnEfectivos.tintColor = sender == btnEfectivos ? COLOR_ACCENT : .darkGray
        btnDepositos.setImage(imgDeposito, for: .normal)
        btnDepositos.tintColor = sender == btnDepositos ? COLOR_ACCENT : .darkGray
        metodoPago = sender == btnDepositos ? "deposito" : "efectivo"
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        miControladorImagen = UIImagePickerController()
        miControladorImagen.delegate = self
        miControladorImagen.sourceType = .camera
        present(miControladorImagen, animated: true, completion: nil)
    }
    
    @IBAction func takeGalery(_ sender: Any) {
        miControladorImagen = UIImagePickerController()
        miControladorImagen.delegate = self
        miControladorImagen.sourceType = .photoLibrary
        present(miControladorImagen, animated: true, completion: nil)
    }
    
    @IBAction func okPago(_ sender: Any) {
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
        
        //TODO: Modificar
        contenedorDepositos.isHidden = true
        btnTomarFotos.isHidden = true
        btnGalerias.isHidden = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        miControladorImagen.dismiss(animated: true, completion: nil)
        imgDepositos.image = info[.originalImage] as? UIImage
        guardaImagen = info[.originalImage] as? UIImage
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        let imageData:NSData = img.jpegData(compressionQuality: 0.50)! as NSData
        let imgString = imageData.base64EncodedString(options: .init(rawValue: 0))
        return imgString
    }

}
