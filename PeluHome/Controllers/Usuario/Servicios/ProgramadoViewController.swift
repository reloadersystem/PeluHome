//
//  ProgramadoViewController.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 10/19/20.
//

import UIKit

class ProgramadoViewController: UIViewController {
    
    @IBOutlet weak var totalServiceTextView: UILabel!
    var profesionales = [Profesional]()
    var idUsuario = 0
    var nombreUsuario = ""
    var direccionUsuario = ""
    var hora = ""
    let anchoVista = UIScreen.main.bounds.width
    let altoVista = UIScreen.main.bounds.height - 163
    var parametros = [Parametros]()
    private var totalPedido: Int16 = 0
    
    @IBOutlet weak var costoDomicilioTxtView: UILabel!
    
    @IBOutlet weak var txtFecha: UITextField!
    @IBOutlet weak var txtHora: UITextField!
    @IBOutlet weak var txtDireccion: UITextField!
    @IBOutlet weak var txtPreferencias: UITextField!
    @IBOutlet weak var lblProfesionalesSeleccionados: UILabel!
    @IBOutlet weak var lblMensajeProfesionales: UILabel!
    @IBOutlet weak var lblPrecioTotal: UILabel!
    @IBOutlet weak var btnMetodoPago: UIButton!
    @IBOutlet weak var btnProgramar: UIButton!
    @IBOutlet weak var contenedorFondo: UIView!
    @IBOutlet weak var contenedorDatePicker: UIView!
    @IBOutlet weak var contenedorTimePicker: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurarUI()
        configurarTextFields()
        listarProfesionales()
        obtenerDatosPersonales()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        btnMetodoPago.setTitle(Programado.shared.formaPago, for: .normal)
    }
    
    @IBAction func mostrarDatePicker(_ sender: Any) {
        datePicker.minimumDate = Date()
        txtFecha.resignFirstResponder()
        configurarContenedorDatePicker()
    }
    
    @IBAction func ocultarDatePicker(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtFecha.text = formatter.string(from: datePicker.date)
        txtFecha.textAlignment = .center
        contenedorDatePicker.removeFromSuperview()
        contenedorFondo.removeFromSuperview()
    }
    
    @IBAction func mostrarTimePicker(_ sender: Any) {
        txtHora.resignFirstResponder()
        configurarContenedorTimePicker()
    }
    
    @IBAction func ocultarTimePicker(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: timePicker.date)
        var hour2 = ""
        switch hour {
            case 0: hour2 = "00"; break
            case 1...9: hour2 = "0\(hour)"; break
            default: hour2 = "\(hour)"
        }
        
        let minute = calendar.component(.minute, from: timePicker.date)
        var minute2 = ""
        switch minute {
            case 0: minute2 = "00"; break
            case 1...9: minute2 = "0\(minute)"; break
            default: minute2 = "\(minute)"
        }
        
        hora = hour2+":"+minute2
        //hora = formatter.string(from: timePicker.date)
        
        txtHora.text = formatter.string(from: timePicker.date)
        txtHora.textAlignment = .center
        contenedorTimePicker.removeFromSuperview()
        contenedorFondo.removeFromSuperview()
    }
    
    @IBAction func seleccionarProfesionales(_ sender: Any) {
        if Programado.shared.accesoPosterior {
            irAProfesionalesVC()
        } else {
            let listaServicios = Programado.shared.listaServicios
            let fecha = txtFecha.text ?? ""
            //let hora = txtHora.text ?? ""
            
            configurarTextFieldsFechaHora()
            let error = validarFechaHora()
            
            if error != nil {
                mostrarAlert(message: error ?? "")
            } else {
                ServiciosWeb.listarServiciosProfesionalesAPI(fecha: fecha, hora: hora, listaServicios: listaServicios) { (profesionalesAPI) in
                    self.profesionales = profesionalesAPI
                    self.irAProfesionalesVC()
                }
            }
        }
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
       
        obtenerParametros(precioTotal: precioTotal)
        
        //btnProgramar.isEnabled = false
        Programado.shared.accesoPosterior = false
    }
    
    func configurarTextFields() {
        txtFecha = MaterialView.textFieldEstiloLogin(textField: txtFecha)
        txtHora = MaterialView.textFieldEstiloLogin(textField: txtHora)
        txtDireccion = MaterialView.textFieldEstiloLogin(textField: txtDireccion)
        txtPreferencias = MaterialView.textFieldEstiloLogin(textField: txtPreferencias)
    }
    
    func obtenerParametros(precioTotal: Int16) {
        ServiciosWeb.obtenerParametrosAPI { (parametrosAPI) in
            self.parametros = parametrosAPI
            print("Parametros \(self.parametros[0].valor)")
            
            if(self.parametros[0].nombreParametro == "costo_envio"){
                let costoAdicionalWebService = Int16(self.parametros[0].valor)
                self.costoDomicilioTxtView.text = "S/ \(self.parametros[0].valor).00"
                self.totalPedido = precioTotal + costoAdicionalWebService!
                self.totalServiceTextView.text = "S/ \(self.totalPedido).00"
            }else {
                self.totalPedido = precioTotal + 10
                self.totalServiceTextView.text = "S/ \(self.totalPedido).00"
            }
        }
    }
   
    
    func configurarTextFieldsFechaHora() {
        txtFecha = MaterialView.textFieldEstiloLogin(textField: txtFecha)
        txtHora = MaterialView.textFieldEstiloLogin(textField: txtHora)
    }
    
    func configurarContenedorDatePicker() {
        contenedorFondo.frame = CGRect(x: 0, y: 0, width: anchoVista, height: altoVista)
        contenedorFondo.backgroundColor = .black
        contenedorFondo.alpha = 0.2
        contenedorDatePicker.frame = CGRect(x: 0, y: 0, width: 300, height: 324)
        contenedorDatePicker.layer.position =  CGPoint(x: anchoVista/2, y: altoVista/2-82)
        self.view.addSubview(contenedorFondo)
        self.view.addSubview(contenedorDatePicker)
    }
    
    func configurarContenedorTimePicker() {
        contenedorFondo.frame = CGRect(x: 0, y: 0, width: anchoVista, height: altoVista)
        contenedorFondo.backgroundColor = .black
        contenedorFondo.alpha = 0.2
        contenedorTimePicker.frame = CGRect(x: 0, y: 0, width: 240, height: 164)
        contenedorTimePicker.layer.position =  CGPoint(x: anchoVista/2, y: altoVista/2-82)
        self.view.addSubview(contenedorFondo)
        self.view.addSubview(contenedorTimePicker)
    }
    
    func listarProfesionales() {
        let context = ContextManager.shared.context
        let servicios = Carrito.listarServicios(inContext: context)
        //let listaServicios = prepararListaServiciosCarrito(servicios: servicios)
        Programado.shared.listaServicios = prepararListaServiciosCarrito(servicios: servicios)
        
//        ServiciosWeb.listarServiciosProfesionalesAPI(listaServicios: listaServicios, fecha: "", hora: "") { (profesionalesAPI) in
//            self.profesionales = profesionalesAPI
//        }
    }
    
    func obtenerDatosPersonales() {
        let codigo = Sesion.shared.codigo()
        
        ServiciosWeb.obtenerDatosPersonalesAPI(codigo: codigo) { (usuario) in
            self.idUsuario = usuario.codigo
            self.nombreUsuario = usuario.nombres + usuario.apellidos
            self.direccionUsuario = usuario.direccion
            // Configurar UI
            self.txtDireccion.text = usuario.direccion
        }
    }

    func prepararListaServiciosCarrito(servicios: [Carrito]) -> [[String:Any]] {
        var listaServicios = [[String:Any]]()
        
        for servicio in servicios {
            let idServicio = Int(servicio.idServicio ?? "") ?? 0
            let itemServicio = ["idServicio": idServicio,
                                "idCategoria": 0,
                                "nombreServicio": "",
                                "nombreCategoria": "",
                                "rutaImagen": "",
                                "precio": "",
                                "disponible": false] as [String : Any]
            listaServicios.append(itemServicio)
        }
        return listaServicios
    }
    
    func prepararListaServiciosRestantes(serviciosSeleccionados: String) {
        let idServicios = serviciosSeleccionados.components(separatedBy: "?")

        for idServicio in idServicios {
            let idServicioInt = Int(idServicio) ?? 0
            Programado.shared.listaServicios.removeAll { (servicio) -> Bool in
                let id = servicio["idServicio"] as? Int ?? 0
                return id == idServicioInt
            }
        }
    }
    
    func agregarPedido(profesional: Profesional) {
        let pedido = Pedido()
        pedido.servicio = profesional.nombreServicio
        pedido.profesional = profesional.nombres
        pedido.usuario = nombreUsuario
        pedido.puntos = 0
        pedido.calificacion = 0
        pedido.estado = "Agendado"
        pedido.codigoUsuario = idUsuario
        pedido.codigoProfesional = profesional.idProfesional
        pedido.codigoServicio = profesional.idServicios
        Programado.shared.pedidos.append(pedido)
    }
    
    func registrarPedido() {
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
            // Deshabilitar boton
            self.btnProgramar.isEnabled = false
            
            // Enviar pedidos
            for pedido in Programado.shared.pedidos {
                let context = ContextManager.shared.context
                let precio = Carrito.calcularTotal(inContext: context)
                pedido.direccion = txtDireccion.text ?? ""
                pedido.preferencias = txtPreferencias.text ?? ""
                pedido.fecha = txtFecha.text ?? ""
                pedido.hora = hora//txtHora.text ?? ""
                pedido.formaPago = Programado.shared.formaPago
                pedido.precio = "\(totalPedido)"
                //pedido.precio = "\(precio)"
                pedido.latitud = "0"
                pedido.longitud = "0"
                pedido.imagen = Programado.shared.imagenDeposito
                
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
    }
    
    func irAProfesionalesVC() {
        let storyBoard = UIStoryboard(name: "Usuario", bundle: nil)
        let _vc = storyBoard.instantiateViewController(withIdentifier: "ProfesionalesVC") as! ProfesionalesViewController
        _vc.modalPresentationStyle = .currentContext
        _vc.profesionales = profesionales
        _vc.profesionalesDelegate = self
        self.navigationController?.pushViewController(_vc, animated: true)
    }
    
    func validarCampos() -> String? {
        let fechaLimpia = txtFecha.text!.trimmingCharacters(in: .newlines)
        
        if fechaLimpia == "" {
            txtFecha = MaterialView.textFieldEstiloInvalido(textField: txtFecha)
            return "Por favor seleccione una fecha"
        }
        
        let horaLimpia = txtHora.text!.trimmingCharacters(in: .newlines)
        
        if horaLimpia == "" {
            txtHora = MaterialView.textFieldEstiloInvalido(textField: txtHora)
            return "Por favor seleccione una hora"
        }
        
        let direccionLimpia = txtDireccion.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if direccionLimpia == "" {
            txtDireccion = MaterialView.textFieldEstiloInvalido(textField: txtDireccion)
            return "Por favor ingresar una direccion"
        }
        
        let metodoPago = Programado.shared.formaPago
        
        if metodoPago != "efectivo" && metodoPago != "deposito" {
            return "Por favor seleccionar metodo de pago"
        }
        
        if !Programado.shared.profesionalesSeleccionados {
            return "Por favor seleccionar todos los profesionales"
        }
        
        return nil
    }
    
    func validarFechaHora() -> String? {
        let fechaLimpia = txtFecha.text!.trimmingCharacters(in: .newlines)
        
        if fechaLimpia == "" {
            txtFecha = MaterialView.textFieldEstiloInvalido(textField: txtFecha)
            return "Por favor seleccione una fecha"
        }
        
        let horaLimpia = txtHora.text!.trimmingCharacters(in: .newlines)
        
        if horaLimpia == "" {
            txtHora = MaterialView.textFieldEstiloInvalido(textField: txtHora)
            return "Por favor seleccione una hora"
        }
        
        return nil
    }
    
    func mostrarAlert(message: String) {
        let alert = UIAlertController(title: "App PeluHome", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert,animated: true)
    }
}

extension ProgramadoViewController: ProfesionalesDelegate {
    func profesionalSeleccionado(profesional: Profesional) {
        Programado.shared.accesoPosterior = true
        // AgregarPedido
        agregarPedido(profesional: profesional)
        
        // Manejo de servicios seleccionados
        let idServicios = profesional.idServicios
        prepararListaServiciosRestantes(serviciosSeleccionados: idServicios)
        let listaServicios = Programado.shared.listaServicios
        let fecha = txtFecha.text ?? ""
        //let hora = txtHora.text ?? ""
        
        configurarTextFieldsFechaHora()
        let error = validarFechaHora()
        
        if error != nil {
            mostrarAlert(message: error ?? "")
        } else {
            // Registro de Pedido
            ServiciosWeb.listarServiciosProfesionalesAPI(fecha: fecha, hora: hora, listaServicios: listaServicios) { (profesionalesAPI) in
                self.profesionales = profesionalesAPI
            }
        }
        
        // Actualizacion de UI
        let nombre = profesional.nombres
        let nombreServicios = profesional.nombreServicio
        let servicios = nombreServicios.replacingOccurrences(of: "?", with: ", ")
        Programado.shared.nSeleccionados = Programado.shared.nSeleccionados + nombreServicios.components(separatedBy:"?").count
        let nSeleccionados = Programado.shared.nSeleccionados
        let nNecesitados = Programado.shared.nNecesitados
        let nFaltantes = nNecesitados - nSeleccionados
        let serviciosSeleccionados = "- \(nombre) -> Servicios: \(servicios)"
        Programado.shared.serviciosSeleccionados = Programado.shared.serviciosSeleccionados + serviciosSeleccionados + "\n"
        lblProfesionalesSeleccionados.text = Programado.shared.serviciosSeleccionados
        
        // Mensaje de servicios seleccionados
        if nFaltantes == 0 {
            lblMensajeProfesionales.text = "Ya tiene todos los servicios escogidos"
            Programado.shared.profesionalesSeleccionados = true
        } else {
            lblMensajeProfesionales.text = "Tiene aun \(nFaltantes) servicios por escoger"
            Programado.shared.profesionalesSeleccionados = false
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
