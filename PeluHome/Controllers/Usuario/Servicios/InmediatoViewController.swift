//
//  InmediatoViewController.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 10/19/20.
//

import UIKit
import CoreLocation

class InmediatoViewController: UIViewController, CLLocationManagerDelegate {
    
    var profesionales = [Profesional]()
    var idUsuario = 0
    var nombreUsuario = ""
    var direccionUsuario = ""
    var idServicios = ""
    var nombreServicios = ""
    var latitud = ""
    var longitud = ""
    let locationManager = CLLocationManager()
    var parametros = [Parametros]()
    var total: Int16 = 0
    
    
    @IBOutlet weak var costoAdicionalTxtView: UILabel!
    
    @IBOutlet weak var totalTxtView: UILabel!
    @IBOutlet weak var txtDireccion: UITextField!
    @IBOutlet weak var txtPreferencias: UITextField!
    @IBOutlet weak var lblPrecioTotal: UILabel!
    @IBOutlet weak var btnMetodoPago: UIButton!
    @IBOutlet weak var btnProgramar: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configurarUI()
        configurarTextFields()
        obtenerDatosPersonales()
        obtenerLocalizacion()
        obtenerServicios()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        btnMetodoPago.setTitle(Inmediato.shared.formaPago, for: .normal)
    }
    
    @IBAction func seleccionarMetodoPago(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Usuario", bundle: nil)
        let _vc = storyBoard.instantiateViewController(withIdentifier: "MetodoPagoVC") as! MetodoPagoViewController
        _vc.modalPresentationStyle = .currentContext
        //_vc.profesionalesDelegate = self
        self.navigationController?.pushViewController(_vc, animated: true)
    }
    
    @IBAction func verDetalleCarrito(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Usuario", bundle: nil)
        let _vc = storyBoard.instantiateViewController(withIdentifier: "CarritoVC") as! CarritoViewController
        _vc.modalPresentationStyle = .currentContext
        //_vc.profesionalesDelegate = self
        self.navigationController?.pushViewController(_vc, animated: true)
    }
    
    @IBAction func programarServicios(_ sender: Any) {
        registrarPedido()
    }
    
    func configurarUI() {
        let context = ContextManager.shared.context
        let precioTotal = Carrito.calcularTotal(inContext: context)
        lblPrecioTotal.text = "S/ \(precioTotal).00"
        //btnProgramar.isEnabled = false
        
        obtenerParametros(precioTotal: precioTotal)
    }
    
    func configurarTextFields() {
        txtDireccion = MaterialView.textFieldEstiloLogin(textField: txtDireccion)
        txtPreferencias = MaterialView.textFieldEstiloLogin(textField: txtPreferencias)
    }
    
    func obtenerParametros(precioTotal: Int16) {
        
        ServiciosWeb.obtenerParametrosAPI { (parametrosAPI) in
            self.parametros = parametrosAPI
            print("Parametros \(self.parametros[0].valor)")
            
            if(self.parametros[0].nombreParametro == "costo_envio"){
                
                let costoAdicionalWebService = Int16(self.parametros[0].valor)!
                
                self.costoAdicionalTxtView.text = "S/ \(self.parametros[0].valor).00"
                
                self.total = precioTotal + costoAdicionalWebService
                
                self.totalTxtView.text = "S/ \(self.total).00"
            }else {
                self.total = precioTotal + 10
                self.totalTxtView.text = "S/ \(self.total).00"
            }
        }
    }
    
    func obtenerDatosPersonales() {
        let codigo = Sesion.shared.codigo()
        
        ServiciosWeb.obtenerDatosPersonalesAPI(codigo: codigo) { (usuario) in
            self.idUsuario = usuario.codigo
            self.nombreUsuario = usuario.nombres + " " + usuario.apellidos
            self.direccionUsuario = usuario.direccion
            // Configurar UI
            self.txtDireccion.text = usuario.direccion
        }
    }
    
    func obtenerLocalizacion() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func obtenerServicios() {
        let context = ContextManager.shared.context
        let carrito = Carrito.listarServicios(inContext: context)
        
        for servicio in carrito {
            let idServicio = servicio.idServicio ?? ""
            let nombreServicio = servicio.nombreServicio ?? ""
            idServicios = idServicios + "?" + idServicio
            nombreServicios = nombreServicios + "?" + nombreServicio
        }
    }
    
    func registrarPedido() {
        
        obtenerLocalizacion()
        configurarTextFields()
        
        // Registro de Pedido
        let error = validarCampos()
        
        if error != nil {
            let alert = UIAlertController(title: "App PeluHome", message: error, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action) in
                // Habilitar boton nuevamente
                self.btnProgramar.isEnabled = true
            }
            alert.addAction(action)
            present(alert,animated: true)
        } else {
            let context = ContextManager.shared.context
            let precio = Carrito.calcularTotal(inContext: context)
            
            
            let pedido = Pedido()
            pedido.servicio = nombreServicios
            pedido.profesional = ""
            pedido.usuario = nombreUsuario
            pedido.puntos = 0
            pedido.calificacion = 0
            pedido.estado = "Registrado"
            pedido.codigoUsuario = idUsuario
            pedido.codigoProfesional = 0
            pedido.codigoServicio = idServicios
            pedido.direccion = txtDireccion.text ?? ""
            pedido.preferencias = txtPreferencias.text ?? ""
            pedido.fecha = ""
            pedido.hora = ""
            pedido.formaPago = Inmediato.shared.formaPago
           // pedido.precio = "\(precio)"
           
            pedido.precio =  "\(total)" 
            pedido.latitud = latitud
            pedido.longitud = longitud
            pedido.imagen = Inmediato.shared.imagenDeposito
            
            // Grabar Pedido
            ServiciosWeb.grabarPedidoAPI(pedido: pedido) { (success, message) in
                if success {
                    // Confirmacion de registro de pedido
                    let alert = UIAlertController(title: "App PeluHome", message: message, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Continuar", style: .default) { (action) in
                        // Habilitar boton nuevamente
                        self.btnProgramar.isEnabled = true
                        // Vaciar carrito
                        let context = ContextManager.shared.context
                        Carrito.eliminarServicios(inContext: context)
                        // Ir a pedidos
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    alert.addAction(action)
                    self.present(alert,animated: true)
                }
            }
        }
    }
    
    func validarCampos() -> String? {
       
        let direccionLimpia = txtDireccion.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if direccionLimpia == "" {
            txtDireccion = MaterialView.textFieldEstiloInvalido(textField: txtDireccion)
            return "Por favor ingresar una direccion"
        }
        
        let metodoPago = Inmediato.shared.formaPago
        
        if metodoPago != "efectivo" && metodoPago != "deposito" {
            return "Por favor seleccionar metodo de pago"
        }
        
        return nil
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            latitud = String(location.coordinate.latitude)
            longitud = String(location.coordinate.longitude)
            print("locations = \(latitud) \(longitud)")
            locationManager.stopUpdatingLocation()
        }
    }
}
