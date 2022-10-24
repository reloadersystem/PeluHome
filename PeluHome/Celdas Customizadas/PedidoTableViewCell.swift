//
//  PedidoTableViewCell.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 11/4/20.
//

import UIKit

class PedidoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblServicios: UILabel!
    @IBOutlet weak var lblProfesional: UILabel!
    @IBOutlet weak var lblDireccion: UILabel!
    @IBOutlet weak var lblMetodoPago: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblHora: UILabel!
    @IBOutlet weak var lblEstado: UILabel!
    @IBOutlet weak var btnDetalle: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
