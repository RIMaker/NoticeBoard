//
//  ItemCollectionViewCell.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import UIKit

class ItemCollectionViewCell: NBCollectionViewCell {
    
    private let nameLabel = UILabel()
    private let phoneNumberLabel = UILabel()
    private let skillsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneNumberLabel)
        contentView.addSubview(skillsLabel)
        setupConstraints()
    }
    
    func update(with data: Any) {
        guard let data = data as? ItemCellData else { return }
        
        nameLabel.text = "title: \(data.title ?? "")"
        phoneNumberLabel.text = "title: \(data.title ?? "")"
        skillsLabel.text = "createdDate: \(data.createdDate ?? "")"
    }
    
    private func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        skillsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            skillsLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 8),
            skillsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            skillsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            skillsLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
