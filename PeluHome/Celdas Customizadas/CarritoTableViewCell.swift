//
//  CarritoTableViewCell.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 11/2/20.
//

import UIKit

class CarritoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblServicioCantidad: UILabel!
    @IBOutlet weak var lblPrecio: UILabel!
    @IBOutlet weak var imgServicio: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
