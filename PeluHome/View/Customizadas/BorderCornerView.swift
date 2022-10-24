//
//  BorderCornerView.swift
//  TeachMe
//
//  Created by Freddy Alexander Quispe Torres on 9/9/20.
//  Copyright © 2020 Freddy Alexander Quispe Torres. All rights reserved.
//

import UIKit

@IBDesignable class BorderCornerView: UIView {

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = self.borderColor.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
            layer.shadowColor = self.shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }

    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }

    // MARK: - Ciclo de vida
    required init?(coder aDecoder: NSCoder) {
        // Usado en al ejecutar el app creado por un storyboard
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        // Usado por al ejecutar el app creado por codigo
        // Cuando diseñe en el storyboard
        super.init(frame: frame)
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: - Ciclo de Muerte
    deinit {
        
    }
    
    // MARK: - Ciclo de Muerte
    private func setupView() {
        layer.borderWidth = self.borderWidth
        layer.borderColor = self.borderColor.cgColor
        layer.cornerRadius = self.cornerRadius
        layer.shadowColor = self.shadowColor.cgColor
        layer.shadowOpacity = self.shadowOpacity
        layer.shadowOffset = self.shadowOffset
    }

}
