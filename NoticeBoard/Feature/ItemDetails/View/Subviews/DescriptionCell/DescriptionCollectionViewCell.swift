//
//  DescriptionCollectionViewCell.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 28.08.2023.
//

import UIKit

final class DescriptionCollectionViewCell: NBCollectionViewCell {
    
    private let viewTitleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    func update(with data: NBCollectionViewCellData) {
        guard let data = data as? DescriptionCellData else { return }
        
        self.descriptionLabel.text = data.description
    }
    
    private func setupViews() {
        contentView.backgroundColor = NBColor.NBMain.backgroundColor
        
        viewTitleLabel.numberOfLines = ViewConstants.viewTitleLabelNumberOfLines
        viewTitleLabel.font = .boldSystemFont(ofSize: ViewConstants.viewTitleLabelFontSize)
        viewTitleLabel.textColor = .black
        viewTitleLabel.text = ViewConstants.viewTitle
        
        descriptionLabel.numberOfLines = ViewConstants.descriptionLabelNumberOfLines
        descriptionLabel.font = .systemFont(ofSize: ViewConstants.descriptionLabelFontSize)
        descriptionLabel.textColor = .black
    }
    
    private func setupConstraints() {
        let vStack = UIStackView(arrangedSubviews: [
            viewTitleLabel,
            descriptionLabel
        ])
        vStack.spacing = 12
        vStack.distribution = .fill
        vStack.alignment = .leading
        vStack.axis = .vertical
        
        contentView.addSubview(vStack)
        
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate enum ViewConstants {
    static let viewTitle = "Описание"
    static let viewTitleLabelNumberOfLines: Int = 0
    static let viewTitleLabelFontSize: CGFloat = 18
    static let descriptionLabelNumberOfLines: Int = 0
    static let descriptionLabelFontSize: CGFloat = 14
}


