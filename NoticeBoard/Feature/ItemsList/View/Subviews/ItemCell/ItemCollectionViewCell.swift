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
    
    func update(with data: NBCollectionViewModelData) {
        guard let data = data as? ItemCellData else { return }
        
        if let imageUrlString = data.imageUrl, let imageUrl = URL(string: imageUrlString)  {
            imageView.loadImage(at: imageUrl)
        }
        titleLabel.text = data.title
        priceLabel.text = data.price
        locationLabel.text = data.location
        
        guard
            let createdDateString = data.createdDate,
            let createdDate = DateFormatter.yyyyMMdd.date(from: createdDateString)
        else {
            dateLabel.text = "-"
            return
        }
        dateLabel.text = DateFormatter.ddMMMMyyyy.string(from: createdDate)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage.imagePlaceholder
        imageView.cancelImageLoad()
    }

    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(dateLabel)
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = ViewConstants.imageViewCornerRadius
        imageView.clipsToBounds = true
        imageView.image = UIImage.imagePlaceholder
        
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 6),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
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
