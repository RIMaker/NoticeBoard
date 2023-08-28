//
//  NBItemDetailsView.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 27.08.2023.
//

import UIKit

final class NBItemDetailsView: UIView, NBItemDetailsViewInput {
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    
    private let imageView = NBGradientImageView(frame: .zero)
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let addressView = AddressView()
    private let dateLabel = UILabel()
    private let descriptionView = DescriptionView()
    private let emailView = ContactView()
    private let phoneNumberView = ContactView()
    
    private var imageViewHeightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    func update(with model: NBItemDetailsViewModel) {
        guard let data = model.data as? NBItemDetailsViewModelDataImpl else { return }
        
        if let imageUrlString = data.imageUrl, let imageUrl = URL(string: imageUrlString) {
            imageView.loadImage(at: imageUrl)
        }
        DispatchQueue.main.async {
            self.titleLabel.text = data.title
            self.priceLabel.text = data.price
            self.descriptionView.update(with: DescriptionViewModel(data: DescriptionViewModelDataImpl(
                description: data.description
            )))
            self.emailView.update(with: ContactViewModel(data: ContactViewModelDataImpl(
                contact: data.email,
                type: .email
            )))
            self.phoneNumberView.update(with: ContactViewModel(data: ContactViewModelDataImpl(
                contact: data.phoneNumber,
                type: .phone
            )))
            self.addressView.update(with: AddressViewModel(
                data: AddressViewModelDataImpl(
                    location: data.location,
                    address: data.address
                )
            ))
            
            guard
                let createdDateString = data.createdDate,
                let createdDate = DateFormatter.yyyyMMdd.date(from: createdDateString)
            else {
                self.dateLabel.text = "-"
                return
            }
            self.dateLabel.text = "Создано \n\(DateFormatter.ddMMyyyy.string(from: createdDate))"
        }
    }
    
    private func setupViews() {
        backgroundColor = NBColor.NBMain.backgroundColor
        
        scrollView.backgroundColor = NBColor.NBMain.backgroundColor
        contentView.backgroundColor = NBColor.NBMain.backgroundColor
        contentView.layer.cornerRadius = ViewConstants.contentViewCornerRadius
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.image = NBImage.imagePlaceholder
        imageView.clipsToBounds = true
        
        titleLabel.numberOfLines = ViewConstants.titleLabelNumberOfLines
        titleLabel.font = .boldSystemFont(ofSize: ViewConstants.titleLabelFontSize)
        titleLabel.textColor = .white
        
        priceLabel.numberOfLines = ViewConstants.priceLabelNumberOfLines
        priceLabel.font = .boldSystemFont(ofSize: ViewConstants.priceLabelFontSize)
        priceLabel.textColor = .black
        
        dateLabel.numberOfLines = ViewConstants.dateLabelNumberOfLines
        dateLabel.font = .systemFont(ofSize: ViewConstants.dateLabelFontSize)
        dateLabel.textColor = .gray
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageViewHeightConstraint?.constant = self.bounds.height * ViewConstants.imageViewHeightScale
        layoutIfNeeded()
    }
    
    private func setupConstraints() {
        let vStack = UIStackView(arrangedSubviews: [
            priceLabel,
            addressView,
            phoneNumberView,
            emailView,
            descriptionView,
            dateLabel,
        ])
        vStack.spacing = 20
        vStack.distribution = .fill
        vStack.alignment = .leading
        vStack.axis = .vertical
        
        vStack.setCustomSpacing(8, after: phoneNumberView)
        vStack.setCustomSpacing(25, after: emailView)
        vStack.setCustomSpacing(25, after: descriptionView)
        
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(contentView)
        contentView.addSubview(vStack)
        imageView.addSubview(titleLabel)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        vStack.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberView.translatesAutoresizingMaskIntoConstraints = false
        emailView.translatesAutoresizingMaskIntoConstraints = false
        
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 200)
        imageViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            contentView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -35),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -45),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: imageView.topAnchor, constant: 8),
            
            vStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            phoneNumberView.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            
            emailView.widthAnchor.constraint(equalTo: vStack.widthAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

fileprivate enum ViewConstants {
    static let titleLabelNumberOfLines: Int = 0
    static let priceLabelNumberOfLines: Int = 0
    static let dateLabelNumberOfLines: Int = 0
    static let titleLabelFontSize: CGFloat = 24
    static let priceLabelFontSize: CGFloat = 24
    static let dateLabelFontSize: CGFloat = 12
    static let imageViewHeightScale: CGFloat = 12 / 27
    static let contentViewCornerRadius: CGFloat = 8
}
