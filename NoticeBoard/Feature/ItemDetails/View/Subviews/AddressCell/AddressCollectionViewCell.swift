//
//  AddressCollectionViewCell.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 28.08.2023.
//

import UIKit

final class AddressCollectionViewCell: NBCollectionViewCell {
    
    private let addressLabel = UILabel()
    private let showOnMapButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    func update(with data: NBCollectionViewCellData) {
        guard let data = data as? AddressCellData else { return }
        
        self.addressLabel.text = data.address
    }
    
    private func setupViews() {
        contentView.backgroundColor = NBColor.NBMain.backgroundColor
        
        addressLabel.numberOfLines = ViewConstants.addressLabelNumberOfLines
        addressLabel.font = .systemFont(ofSize: ViewConstants.addressLabelFontSize)
        addressLabel.textColor = .black
        
        showOnMapButton.setTitle(ViewConstants.showOnMapButtonTitle, for: .normal)
        showOnMapButton.setTitleColor(UIColor.systemBlue, for: .normal)
        showOnMapButton.setTitleColor(UIColor.systemBlue.withAlphaComponent(0.6), for: .highlighted)
        showOnMapButton.titleLabel?.font = .systemFont(ofSize: ViewConstants.showOnMapButtonFontSize)
    }
    
    private func setupConstraints() {
        let vStack = UIStackView(arrangedSubviews: [
            addressLabel,
            showOnMapButton
        ])
        vStack.spacing = 2
        vStack.distribution = .fill
        vStack.alignment = .leading
        vStack.axis = .vertical
        
        contentView.addSubview(vStack)
        
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate enum ViewConstants {
    static let addressLabelNumberOfLines: Int = 0
    static let addressLabelFontSize: CGFloat = 14
    static let showOnMapButtonFontSize: CGFloat = 14
    static let showOnMapButtonTitle = "Показать на карте"
}
