//
//  TextCollectionViewCell.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 30.09.2023.
//

import UIKit

final class TextCollectionViewCell: NBCollectionViewCell {
    
    private let textLabel = UILabel()
    
    func update(with data: NBCollectionViewCellData) {
        guard let data = data as? TextCellData else { return }
        
        let font: UIFont
        
        switch data.font {
        case .bold:
            font = .boldSystemFont(ofSize: data.fontSize)
        case .regular:
            font = .systemFont(ofSize: data.fontSize)
        }
        
        let textColor: UIColor
        switch data.color {
        case .black:
            textColor = .black
        case .gray:
            textColor = .gray
        }
        
        self.textLabel.text = data.text
        self.textLabel.font = font
        self.textLabel.textColor = textColor
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        contentView.backgroundColor = NBColor.NBMain.backgroundColor
        
        textLabel.numberOfLines = 0
        textLabel.textColor = .black
    }
    
    private func setupConstraints() {
        contentView.addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
