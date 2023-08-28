//
//  ContactView.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 28.08.2023.
//

import UIKit

final class ContactView: UIView, ContactViewInput {
    
    var contactByHandler: ((_ contact: String?) -> Void)?
    
    private let contactLabel = UILabel()
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    func update(with model: ContactViewModel) {
        guard let data = model.data as? ContactViewModelDataImpl else { return }
        
        DispatchQueue.main.async {
            self.contactLabel.text = data.contact
            switch data.type {
            case .email:
                self.imageView.image = NBImage.emailIcon
                self.backgroundColor = UIColor(red: 0 / 255, green: 192 / 255, blue: 255 / 255, alpha: 1)
            case .phone:
                self.imageView.image = NBImage.phoneIcon
                self.backgroundColor = UIColor(red: 106 / 255, green: 188 / 255, blue: 75 / 255, alpha: 1)
            }
        }
    }
    
    private func setupViews() {
        layer.cornerRadius = 8
        clipsToBounds = true
        backgroundColor = NBColor.NBMain.backgroundColor
        
        contactLabel.numberOfLines = ViewConstants.contactLabelNumberOfLines
        contactLabel.font = .boldSystemFont(ofSize: ViewConstants.contactLabelFontSize)
        contactLabel.textColor = .white
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        
        isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedOnContactView))
        addGestureRecognizer(tapGestureRecognizer)
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
        
        addSubview(hStack)
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: ViewConstants.selfHeight),
            
            hStack.topAnchor.constraint(equalTo: topAnchor),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.widthAnchor.constraint(equalToConstant: ViewConstants.imageViewSize),
            imageView.heightAnchor.constraint(equalToConstant: ViewConstants.imageViewSize)
        ])
        
    }
    
    @objc
    private func tappedOnContactView(_ sender: UITapGestureRecognizer) {
        contactByHandler?(contactLabel.text)
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

