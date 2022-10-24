//
//  CategoriasTableViewCell.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 10/18/20.
//

import UIKit

class CategoriasTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCategoria: UILabel!
    @IBOutlet weak var imgCategoria: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
