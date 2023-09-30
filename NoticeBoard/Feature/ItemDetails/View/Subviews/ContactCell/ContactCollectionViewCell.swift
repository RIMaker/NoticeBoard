//
//  ContactCollectionViewCell.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 28.08.2023.
//

import UIKit

final class ContactCollectionViewCell: NBCollectionViewCell {
    
    private let contactLabel = UILabel()
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    func update(with data: NBCollectionViewCellData) {
        guard let data = data as? ContactCellData else { return }
        
        self.contactLabel.text = data.contact
        switch data.type {
        case .email:
            self.imageView.image = NBImage.emailIcon
            self.contentView.backgroundColor = UIColor(red: 0 / 255, green: 192 / 255, blue: 255 / 255, alpha: 1)
        case .phone:
            self.imageView.image = NBImage.phoneIcon
            self.contentView.backgroundColor = UIColor(red: 106 / 255, green: 188 / 255, blue: 75 / 255, alpha: 1)
        }
    }
    
    private func setupViews() {
        contentView.backgroundColor = NBColor.NBMain.backgroundColor
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        contactLabel.numberOfLines = ViewConstants.contactLabelNumberOfLines
        contactLabel.font = .boldSystemFont(ofSize: ViewConstants.contactLabelFontSize)
        contactLabel.textColor = .white
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
    }
    
    private func setupConstraints() {
        let hStack = UIStackView(arrangedSubviews: [
            contactLabel,
            imageView
        ])
        hStack.spacing = 10
        hStack.distribution = .fill
        hStack.alignment = .center
        hStack.axis = .horizontal
        
        contentView.addSubview(hStack)
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hStack.heightAnchor.constraint(equalToConstant: ViewConstants.selfHeight),
            hStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            hStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            hStack.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -12),
            hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.widthAnchor.constraint(equalToConstant: ViewConstants.imageViewSize),
            imageView.heightAnchor.constraint(equalToConstant: ViewConstants.imageViewSize)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate enum ViewConstants {
    static let selfHeight: CGFloat = 46
    static let contactLabelNumberOfLines: Int = 1
    static let contactLabelFontSize: CGFloat = 16
    static let imageViewSize: CGFloat = 30
}

