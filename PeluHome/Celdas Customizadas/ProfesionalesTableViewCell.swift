//
//  ProfesionalesTableViewCell.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 11/2/20.
//

import UIKit

class ProfesionalesTableViewCell: UITableViewCell {
    var puntaje = 0.0
    
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblProfesion: UILabel!
    @IBOutlet weak var lblServicios: UILabel!
    @IBOutlet weak var imgProfesional: UIImageView!
    @IBOutlet weak var imgEstrella1: UIImageView!
    @IBOutlet weak var imgEstrella2: UIImageView!
    @IBOutlet weak var imgEstrella3: UIImageView!
    @IBOutlet weak var imgEstrella4: UIImageView!
    @IBOutlet weak var imgEstrella5: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func configurarImagenes(puntaje: Double) {
        switch puntaje {
        case 0.5...0.99:
            imgEstrella1.image = UIImage(systemName: "star.fill.left"); imgEstrella1.tintColor = .systemOrange
            imgEstrella2.image = UIImage(systemName: "star"); imgEstrella2.tintColor = .systemGray
            imgEstrella3.image = UIImage(systemName: "star"); imgEstrella3.tintColor = .systemGray
            imgEstrella4.image = UIImage(systemName: "star"); imgEstrella4.tintColor = .systemGray
            imgEstrella5.image = UIImage(systemName: "star"); imgEstrella5.tintColor = .systemGray
        case 1.0...1.49:
            imgEstrella1.image = UIImage(systemName: "star.fill"); imgEstrella1.tintColor = .systemOrange
            imgEstrella2.image = UIImage(systemName: "star"); imgEstrella2.tintColor = .systemGray
            imgEstrella3.image = UIImage(systemName: "star"); imgEstrella3.tintColor = .systemGray
            imgEstrella4.image = UIImage(systemName: "star"); imgEstrella4.tintColor = .systemGray
            imgEstrella5.image = UIImage(systemName: "star"); imgEstrella5.tintColor = .systemGray
        case 1.5...1.99:
            imgEstrella1.image = UIImage(systemName: "star.fill"); imgEstrella1.tintColor = .systemOrange
            imgEstrella2.image = UIImage(systemName: "star.fill.left"); imgEstrella2.tintColor = .systemOrange
            imgEstrella3.image = UIImage(systemName: "star"); imgEstrella3.tintColor = .systemGray
            imgEstrella4.image = UIImage(systemName: "star"); imgEstrella4.tintColor = .systemGray
            imgEstrella5.image = UIImage(systemName: "star"); imgEstrella5.tintColor = .systemGray
        case 2.0...2.49:
            imgEstrella1.image = UIImage(systemName: "star.fill"); imgEstrella1.tintColor = .systemOrange
            imgEstrella2.image = UIImage(systemName: "star.fill"); imgEstrella2.tintColor = .systemOrange
            imgEstrella3.image = UIImage(systemName: "star"); imgEstrella3.tintColor = .systemGray
            imgEstrella4.image = UIImage(systemName: "star"); imgEstrella4.tintColor = .systemGray
            imgEstrella5.image = UIImage(systemName: "star"); imgEstrella5.tintColor = .systemGray
        case 2.5...2.99:
            imgEstrella1.image = UIImage(systemName: "star.fill"); imgEstrella1.tintColor = .systemOrange
            imgEstrella2.image = UIImage(systemName: "star.fill"); imgEstrella2.tintColor = .systemOrange
            imgEstrella3.image = UIImage(systemName: "star.fill.left"); imgEstrella3.tintColor = .systemOrange
            imgEstrella4.image = UIImage(systemName: "star"); imgEstrella4.tintColor = .systemGray
            imgEstrella5.image = UIImage(systemName: "star"); imgEstrella5.tintColor = .systemGray
        case 3.0...3.49:
            imgEstrella1.image = UIImage(systemName: "star.fill"); imgEstrella1.tintColor = .systemOrange
            imgEstrella2.image = UIImage(systemName: "star.fill"); imgEstrella2.tintColor = .systemOrange
            imgEstrella3.image = UIImage(systemName: "star.fill"); imgEstrella3.tintColor = .systemOrange
            imgEstrella4.image = UIImage(systemName: "star"); imgEstrella4.tintColor = .systemGray
            imgEstrella5.image = UIImage(systemName: "star"); imgEstrella5.tintColor = .systemGray
        case 3.5...3.99:
            imgEstrella1.image = UIImage(systemName: "star.fill"); imgEstrella1.tintColor = .systemOrange
            imgEstrella2.image = UIImage(systemName: "star.fill"); imgEstrella2.tintColor = .systemOrange
            imgEstrella3.image = UIImage(systemName: "star.fill"); imgEstrella3.tintColor = .systemOrange
            imgEstrella4.image = UIImage(systemName: "star.fill.left"); imgEstrella4.tintColor = .systemOrange
            imgEstrella5.image = UIImage(systemName: "star"); imgEstrella5.tintColor = .systemGray
        case 4.0...4.49:
            imgEstrella1.image = UIImage(systemName: "star.fill"); imgEstrella1.tintColor = .systemOrange
            imgEstrella2.image = UIImage(systemName: "star.fill"); imgEstrella2.tintColor = .systemOrange
            imgEstrella3.image = UIImage(systemName: "star.fill"); imgEstrella3.tintColor = .systemOrange
            imgEstrella4.image = UIImage(systemName: "star.fill"); imgEstrella4.tintColor = .systemOrange
            imgEstrella5.image = UIImage(systemName: "star"); imgEstrella5.tintColor = .systemGray
        case 4.5...4.99:
            imgEstrella1.image = UIImage(systemName: "star.fill"); imgEstrella1.tintColor = .systemOrange
            imgEstrella2.image = UIImage(systemName: "star.fill"); imgEstrella2.tintColor = .systemOrange
            imgEstrella3.image = UIImage(systemName: "star.fill"); imgEstrella3.tintColor = .systemOrange
            imgEstrella4.image = UIImage(systemName: "star.fill"); imgEstrella4.tintColor = .systemOrange
            imgEstrella5.image = UIImage(systemName: "star.fill.left"); imgEstrella5.tintColor = .systemOrange
        case 5.0:
            imgEstrella1.image = UIImage(systemName: "star.fill"); imgEstrella1.tintColor = .systemOrange
            imgEstrella2.image = UIImage(systemName: "star.fill"); imgEstrella2.tintColor = .systemOrange
            imgEstrella3.image = UIImage(systemName: "star.fill"); imgEstrella3.tintColor = .systemOrange
            imgEstrella4.image = UIImage(systemName: "star.fill"); imgEstrella4.tintColor = .systemOrange
            imgEstrella5.image = UIImage(systemName: "star.fill"); imgEstrella5.tintColor = .systemOrange
        default:
            print("")
        }
    }
}
