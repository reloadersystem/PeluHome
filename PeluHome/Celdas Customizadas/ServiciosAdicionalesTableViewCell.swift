//
//  ServiciosAdicionalesTableViewCell.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 27/01/21.
//

import UIKit

class ServiciosAdicionalesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblServicio: UILabel!
    @IBOutlet weak var lblPrecio: UILabel!
    @IBOutlet weak var lblCantidad: UILabel!
    //@IBOutlet weak var imgServicio: UIImageView!
    @IBOutlet weak var btnSumar: UIButton!
    @IBOutlet weak var btnRestar: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        btnSumar.backgroundColor = COLOR_PRIMARIO
        btnRestar.backgroundColor = COLOR_PRIMARIO
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
