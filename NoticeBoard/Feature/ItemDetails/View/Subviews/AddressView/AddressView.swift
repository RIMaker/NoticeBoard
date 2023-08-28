//
//  AddressView.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 28.08.2023.
//

import UIKit

final class AddressView: UIView, AddressViewInput {
    
    private let addressLabel = UILabel()
    private let showOnMapLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    func update(with model: AddressViewModel) {
        guard let data = model.data as? AddressViewModelDataImpl else { return }
        
        DispatchQueue.main.async {
            var newAddress = data.location ?? ""
            if let address = data.address {
                newAddress += ", \(address)"
            }
            self.addressLabel.text = newAddress
        }
    }
    
    private func setupViews() {
        backgroundColor = NBColor.NBMain.backgroundColor
        
        addressLabel.numberOfLines = ViewConstants.addressLabelNumberOfLines
        addressLabel.font = .systemFont(ofSize: ViewConstants.addressLabelFontSize)
        addressLabel.textColor = .black
        
        showOnMapLabel.numberOfLines = ViewConstants.showOnMapLabelNumberOfLines
        showOnMapLabel.font = .systemFont(ofSize: ViewConstants.showOnMapLabelFontSize)
        showOnMapLabel.textColor = .systemBlue
        showOnMapLabel.text = ViewConstants.showOnMapLabelTitle
    }
    
    private func setupConstraints() {
        let vStack = UIStackView(arrangedSubviews: [
            addressLabel,
            showOnMapLabel
        ])
        vStack.spacing = 4
        vStack.distribution = .fill
        vStack.alignment = .leading
        vStack.axis = .vertical
        
        addSubview(vStack)
        
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate enum ViewConstants {
    static let addressLabelNumberOfLines: Int = 0
    static let addressLabelFontSize: CGFloat = 14
    static let showOnMapLabelNumberOfLines: Int = 0
    static let showOnMapLabelFontSize: CGFloat = 14
    static let showOnMapLabelTitle = "Показать на карте"
}
