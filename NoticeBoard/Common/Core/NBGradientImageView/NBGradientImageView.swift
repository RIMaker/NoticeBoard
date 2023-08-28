//
//  NBGradientImageView.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 28.08.2023.
//

import UIKit

class NBGradientImageView: UIImageView {
    
    private let gradient = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = layer.frame
    }
    
    func setupPlaceholder() {
        image = NBImage.imagePlaceholder
    }
    
    private func setup() {
        setupPlaceholder()
        contentMode = .scaleAspectFill
        tintColor = .lightGray
        clipsToBounds = true
        
        gradient.colors = [
            
            UIColor(red: 13/255, green: 8/255, blue: 30/255, alpha: 0).cgColor,
            
            UIColor(red: 13/255, green: 8/255, blue: 30/255, alpha: 0.51).cgColor,
            
            UIColor(red: 13/255, green: 8/255, blue: 30/255, alpha: 1).cgColor
            
        ]
        layer.insertSublayer(gradient, at: 0)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder) is not implemented")
    }

}


