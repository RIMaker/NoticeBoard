//
//  ImageCollectionViewCell.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 30.09.2023.
//

import UIKit

final class ImageCollectionViewCell: NBCollectionViewCell {
    
    private let imageView = UIImageView()
    
    func update(with data: NBCollectionViewCellData) {
        guard let data = data as? ImageCellData else { return }
        
        if let imageUrl = data.imageUrl {
            imageView.loadImage(at: imageUrl)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.cancelImageLoad()
        imageView.image = NBImage.imagePlaceholder
    }
    
    private func setupViews() {
        backgroundColor = NBColor.NBMain.backgroundColor
        
        imageView.contentMode = .scaleAspectFill
        imageView.image = NBImage.imagePlaceholder
        
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
    }
    
    private func setupConstraints() {
        contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, constant: -100)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
