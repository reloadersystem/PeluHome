//
//  ReservaViewController.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 10/19/20.
//

import UIKit

class ReservaViewController: UIViewController {
    
    @IBOutlet weak var btnInmediato: UIButton!
    @IBOutlet weak var btnProgramado: UIButton!
    @IBOutlet weak var contenedorInmediato: UIView!
    @IBOutlet weak var contenedorProgramado: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        actualizarUI()
        resetearProgramado()
    }
    
    @IBAction func reservaInmediata(_ sender: Any) {
        btnInmediato.backgroundColor = COLOR_PRIMARIO
        btnProgramado.backgroundColor = COLOR_ACCENT
        contenedorInmediato.isHidden = false
        contenedorProgramado.isHidden = true
    }
    
    @IBAction func reservaProgramada(_ sender: Any) {
        btnInmediato.backgroundColor = COLOR_ACCENT
        btnProgramado.backgroundColor = COLOR_PRIMARIO
        contenedorInmediato.isHidden = true
        contenedorProgramado.isHidden = false
    }
    
    func actualizarUI() {
//        btnInmediato.redondeoLateralIzquierdo(radio: 6.0)
//        btnProgramado.redondeoLateralDerecho(radio: 6.0)
        btnInmediato.backgroundColor = COLOR_ACCENT
        btnProgramado.backgroundColor = COLOR_PRIMARIO
        contenedorInmediato.isHidden = true
        contenedorProgramado.isHidden = false
        //btnInmediato.backgroundColor = COLOR_PRIMARIO
        //btnProgramado.backgroundColor = COLOR_ACCENT
        //contenedorInmediato.isHidden = false
        //contenedorProgramado.isHidden = true
    }
    
    func resetearProgramado() {
        let context = ContextManager.shared.context
        Programado.shared.nNecesitados = Carrito.obtenerServicios(inContext: context)
        Programado.shared.nSeleccionados = 0
        Programado.shared.serviciosSeleccionados = ""
        Programado.shared.pedidos = [Pedido]()
        Programado.shared.imagenDeposito = ""
        Programado.shared.formaPago = "Seleccionar"
        Programado.shared.profesionalesSeleccionados = false
    }
    
    func resetearInmediato() {
        Inmediato.shared.formaPago = "Seleccionar"
    }
    
}
