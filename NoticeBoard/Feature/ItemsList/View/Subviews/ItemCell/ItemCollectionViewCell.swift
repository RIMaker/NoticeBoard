//
//  ItemCollectionViewCell.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import UIKit

class ItemCollectionViewCell: NBCollectionViewCell {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let locationLabel = UILabel()
    private let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setupViews()
        setupConstraints()
    }
    
    func update(with data: NBCollectionViewCellData) {
        guard let data = data as? ItemCellData else { return }
        
        if let imageUrl = data.imageUrl  {
            imageView.loadImage(at: imageUrl)
        }
        titleLabel.text = data.title
        priceLabel.text = data.price
        locationLabel.text = data.location
        
        guard let createdDate = data.createdDate else {
            dateLabel.text = "-"
            return
        }
        dateLabel.text = DateFormatter.ddMMyyyy.string(from: createdDate)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.cancelImageLoad()
        imageView.image = NBImage.imagePlaceholder
    }

    private func setupViews() {
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = ViewConstants.imageViewCornerRadius
        imageView.clipsToBounds = true
        imageView.image = NBImage.imagePlaceholder
        
        titleLabel.numberOfLines = ViewConstants.titleLabelNumberOfLines
        titleLabel.font = .systemFont(ofSize: ViewConstants.titleLabelFontSize)
        titleLabel.textColor = .black
        
        priceLabel.font = .boldSystemFont(ofSize: ViewConstants.priceLabelFontSize)
        priceLabel.textColor = .black
        
        locationLabel.font = .systemFont(ofSize: ViewConstants.locationLabelFontSize)
        locationLabel.textColor = .lightGray
        
        dateLabel.font = .systemFont(ofSize: ViewConstants.dateLabelFontSize)
        dateLabel.textColor = .lightGray
    }
    
    private func setupConstraints() {
        let vStack = UIStackView(arrangedSubviews: [
            imageView,
            titleLabel,
            priceLabel,
            locationLabel,
            dateLabel
        ])
        vStack.spacing = 6
        vStack.distribution = .fill
        vStack.alignment = .leading
        vStack.axis = .vertical
        vStack.setCustomSpacing(4, after: locationLabel)
        contentView.addSubview(vStack)
        
        vStack.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

fileprivate enum ViewConstants {
    static let imageViewCornerRadius: CGFloat = 8
    static let titleLabelNumberOfLines: Int = 2
    static let titleLabelFontSize: CGFloat = 16
    static let priceLabelFontSize: CGFloat = 16
    static let locationLabelFontSize: CGFloat = 12
    static let dateLabelFontSize: CGFloat = 12
}
