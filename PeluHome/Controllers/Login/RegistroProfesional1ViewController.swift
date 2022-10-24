//
//  RegistroProfesional1ViewController.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 7/12/20.
//

import UIKit

class RegistroProfesional1ViewController: UIViewController {
    
    var departamentos = [Departamento]()
    var provincias = [Provincia]()
    var distritos = [Distrito]()
    var indicePicker = 0
    var idDepartamento = 0
    var idProvincia = 0
    var idDistrito = 0
    let anchoVista = UIScreen.main.bounds.width
    let altoVista = UIScreen.main.bounds.height
    let token = Sesion.shared.token()

    @IBOutlet weak var txtNombres: UITextField!
    @IBOutlet weak var txtApellidos: UITextField!
    @IBOutlet weak var txtProfesion: UITextField!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtDocumento: UITextField!
    @IBOutlet weak var txtCelular: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtDepartamento: UITextField!
    @IBOutlet weak var txtProvincia: UITextField!
    @IBOutlet weak var txtDistrito: UITextField!
    @IBOutlet weak var txtDireccion: UITextField!
    @IBOutlet weak var contenedorFondo: UIView!
    @IBOutlet weak var contenedorPicker: UIView!
    @IBOutlet weak var pickerView: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurarTextFields()
        desHabilitarSpinners()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ServiciosWeb.obtenerDepartamentosAPI { (departamentosAPI) in
            self.departamentos = departamentosAPI
            self.txtDepartamento.isEnabled = self.departamentos.count > 1 ? true : false
            self.txtDepartamento.placeholder = self.departamentos.count > 1 ? self.departamentos[0].descripcion : ""
        }
    }
    
    @IBAction func volverAtras(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func mostrarPickerDepartamento(_ sender: Any) {
        txtDepartamento.resignFirstResponder()
        txtDepartamento.text = departamentos[0].descripcion
        txtProvincia.placeholder = ""
        txtProvincia.text = ""
        txtDistrito.placeholder = ""
        txtDistrito.text = ""
        indicePicker = 1
        configurarContenedores()
    }
    
    @IBAction func mostrarPickerProvincia(_ sender: Any) {
        txtProvincia.resignFirstResponder()
        txtProvincia.text = provincias[0].descripcion
        txtDistrito.placeholder = ""
        txtDistrito.text = ""
        indicePicker = 2
        configurarContenedores()
    }
    
    @IBAction func mostrarPickerDistrito(_ sender: Any) {
        txtDistrito.resignFirstResponder()
        txtDistrito.text = distritos[0].descripcion
        indicePicker = 3
        configurarContenedores()
    }
    
    @IBAction func ocultarPickers(_ sender: Any) {
        if indicePicker == 1 { obtenerProvincias(idDepartamento: idDepartamento) }
        if indicePicker == 2 { obtenerDistritos(idProvincia: idProvincia) }
        contenedorPicker.removeFromSuperview()
        contenedorFondo.removeFromSuperview()
    }
    
    @IBAction func irARegistroProfesional2(_ sender: UIButton) {
        configurarTextFields()
        // Registro de usuario
        let error = validarCampos()
        
        //if false {
        if error != nil {
            let alert = UIAlertController(title: "App PeluHome", message: error, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert,animated: true)
        } else {
            // Enviar datos de Registro de Usuario
            let usuario = Usuario()
            usuario.nombres = txtNombres.text ?? ""
            usuario.apellidos = txtApellidos.text ?? ""
            usuario.profesion = txtProfesion.text ?? ""
            usuario.correo = txtCorreo.text ?? ""
            usuario.documento = txtDocumento.text ?? ""
            usuario.celular = txtCelular.text ?? ""
            usuario.clave = txtPassword.text ?? ""
            usuario.departamento = idDepartamento
            usuario.provincia = idProvincia
            usuario.distrito = idDistrito
            usuario.direccion = txtDireccion.text ?? ""
            usuario.rol = "Profesional"
            usuario.estado = "Registrado"
            usuario.token = token
            usuario.imagen = ""
            usuario.disponible = 1
            usuario.estadoActivo = false
            
            let storyBoard = UIStoryboard(name: "Login", bundle: nil)
            let _vc = storyBoard.instantiateViewController(withIdentifier: "RegistroProfesional2VC") as! RegistroProfesional2ViewController
            _vc.modalPresentationStyle = .currentContext
            _vc.usuario = usuario
            self.navigationController?.pushViewController(_vc, animated: true)
        }
    }
    
    func configurarTextFields() {
        txtNombres = MaterialView.textFieldEstiloLogin(textField: txtNombres)
        txtApellidos = MaterialView.textFieldEstiloLogin(textField: txtApellidos)
        txtProfesion = MaterialView.textFieldEstiloLogin(textField: txtProfesion)
        txtCorreo = MaterialView.textFieldEstiloLogin(textField: txtCorreo)
        txtDocumento = MaterialView.textFieldEstiloLogin(textField: txtDocumento)
        txtCelular = MaterialView.textFieldEstiloLogin(textField: txtCelular)
        txtPassword = MaterialView.textFieldEstiloLogin(textField: txtPassword)
        txtDepartamento = MaterialView.textFieldEstiloLogin(textField: txtDepartamento)
        txtProvincia = MaterialView.textFieldEstiloLogin(textField: txtProvincia)
        txtDistrito = MaterialView.textFieldEstiloLogin(textField: txtDistrito)
        txtDireccion = MaterialView.textFieldEstiloLogin(textField: txtDireccion)
    }
    
    func desHabilitarSpinners() {
        txtDepartamento.isEnabled = false
        txtProvincia.isEnabled = false
        txtDistrito.isEnabled = false
    }
    
    func configurarContenedores() {
        contenedorFondo.frame = CGRect(x: 0, y: 0, width: anchoVista, height: altoVista)
        contenedorFondo.backgroundColor = .black
        contenedorFondo.alpha = 0.2
        contenedorPicker.frame = CGRect(x: 0, y: 0, width: anchoVista-80, height: 240)
        contenedorPicker.layer.position =  CGPoint(x: anchoVista/2, y: altoVista/2)
        self.view.addSubview(contenedorFondo)
        self.view.addSubview(contenedorPicker)
        pickerView.reloadAllComponents()
    }
    
    func obtenerProvincias(idDepartamento: Int) {
        ServiciosWeb.obtenerProvinciasAPI(idDepartamento: idDepartamento) { (provinciasAPI) in
            self.provincias = provinciasAPI
            self.txtProvincia.isEnabled = self.provincias.count > 1 ? true : false
            self.txtProvincia.placeholder = self.provincias.count > 1 ? self.provincias[0].descripcion : ""
        }
    }
    
    func obtenerDistritos(idProvincia: Int) {
        ServiciosWeb.obtenerDistritosAPI(idProvincia: idProvincia) { (distritosAPI) in
            self.distritos = distritosAPI
            self.txtDistrito.isEnabled = self.distritos.count > 1 ? true : false
            self.txtDistrito.placeholder = self.distritos.count > 1 ? self.distritos[0].descripcion : ""
        }
    }
    
    func validarCampos() -> String? {
        let nombresLimpio = txtNombres.text!.trimmingCharacters(in: .newlines)
        
        if nombresLimpio == "" {
            txtNombres = MaterialView.textFieldEstiloInvalido(textField: txtNombres)
            return "Por favor ingresar nombre(s)"
        }
        
        let apellidosLimpio = txtApellidos.text!.trimmingCharacters(in: .newlines)
        
        if apellidosLimpio == "" {
            txtApellidos = MaterialView.textFieldEstiloInvalido(textField: txtApellidos)
            return "Por favor ingresar apellido(s)"
        }
        
        let profesionLimpio = txtProfesion.text!.trimmingCharacters(in: .newlines)
        
        if profesionLimpio == "" {
            txtProfesion = MaterialView.textFieldEstiloInvalido(textField: txtProfesion)
            return "Por favor ingresar profesion"
        }
        
        let correoLimpio = txtCorreo.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        if Utilitarios.esCorreoValido(correoLimpio) == false {
            txtCorreo = MaterialView.textFieldEstiloInvalido(textField: txtCorreo)
            return "Por favor ingresar un correo valido"
        }
        
        let documentoLimpio = txtDocumento.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        if !documentoLimpio.isEmpty {
            if Utilitarios.esDocumentoValido(documentoLimpio) == false {
                txtDocumento = MaterialView.textFieldEstiloInvalido(textField: txtDocumento)
                return "Por favor ingresar un documento valido, debe tener 8 digitos"
            }
        }
        
        let celularLimpio = txtCelular.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        if Utilitarios.esCelularValido(celularLimpio) == false {
            txtCelular = MaterialView.textFieldEstiloInvalido(textField: txtCelular)
            return "Por favor ingresar un celular valido"
        }
        
        let claveLimpia = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        if Utilitarios.esClaveValida(claveLimpia) == false {
            txtPassword = MaterialView.textFieldEstiloInvalido(textField: txtPassword)
            return "La contraseña debe tener al menos 6 caracteres !"
        }
        
        let departamentoLimpio = txtDepartamento.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if departamentoLimpio == ""  || departamentoLimpio.contains("seleccione") {
            txtDepartamento = MaterialView.textFieldEstiloInvalido(textField: txtDepartamento)
            return "Por favor seleccionar un departamento"
        }
        
        let provinciaLimpia = txtProvincia.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if provinciaLimpia == ""  || provinciaLimpia.contains("seleccione") {
            txtProvincia = MaterialView.textFieldEstiloInvalido(textField: txtProvincia)
            return "Por favor seleccionar una provincia"
        }
        
        let distritoLimpio = txtDistrito.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if distritoLimpio == ""  || distritoLimpio.contains("seleccione") {
            txtDistrito = MaterialView.textFieldEstiloInvalido(textField: txtDistrito)
            return "Por favor seleccionar un distrito"
        }
        
        let direccionLimpia = txtDireccion.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if direccionLimpia == "" {
            txtDireccion = MaterialView.textFieldEstiloInvalido(textField: txtDireccion)
            return "Por favor ingresar una direccion"
        }
        
        return nil
    }
}

extension RegistroProfesional1ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch indicePicker {
            case 1: return departamentos.count
            case 2: return provincias.count
            case 3: return distritos.count
            default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var descripciones = [String]()
        switch indicePicker {
            case 1: descripciones = departamentos.map { (descripcion) -> String in descripcion.descripcion }
            case 2: descripciones = provincias.map { (descripcion) -> String in descripcion.descripcion }
            case 3: descripciones = distritos.map { (descripcion) -> String in descripcion.descripcion }
            default: print("")
        }
        return descripciones[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var descripciones = [String]()
        var codigos = [Int]()
        switch indicePicker {
            case 1:
                descripciones = departamentos.map { (descripcion) -> String in descripcion.descripcion }
                codigos = departamentos.map { (codigo) -> Int in codigo.codigo }
                txtDepartamento.text = descripciones[row]
                idDepartamento = codigos[row]
            case 2:
                descripciones = provincias.map { (descripcion) -> String in descripcion.descripcion }
                codigos = provincias.map { (codigo) -> Int in codigo.codigo }
                txtProvincia.text = descripciones[row]
                idProvincia = codigos[row]
            case 3:
                descripciones = distritos.map { (descripcion) -> String in descripcion.descripcion }
                codigos = distritos.map { (codigo) -> Int in codigo.codigo }
                txtDistrito.text = descripciones[row]
                idDistrito = codigos[row]
            default: print("")
        }
    }
    
}
