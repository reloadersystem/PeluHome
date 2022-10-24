//
//  ServiciosTableViewCell.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 10/18/20.
//

import UIKit

class ServiciosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblServicio: UILabel!
    @IBOutlet weak var lblPrecio: UILabel!
    @IBOutlet weak var lblCantidad: UILabel!
    //@IBOutlet weak var imgServicio: UIImageView!
    @IBOutlet weak var btnSumar: UIButton!
    @IBOutlet weak var btnRestar: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        btnSumar.redondeoSuperiorDerecho(radio: 10.0)
        btnSumar.backgroundColor = COLOR_PRIMARIO
        btnRestar.redondeoInferiorDerecho(radio: 10.0)
        btnRestar.backgroundColor = COLOR_PRIMARIO
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
