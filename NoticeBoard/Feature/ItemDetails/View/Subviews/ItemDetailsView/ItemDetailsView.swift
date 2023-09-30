//
//  NBItemDetailsView.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 27.08.2023.
//

import UIKit

final class ItemDetailsView: NBView {
    
    var onTopRefresh: (() -> ())?
    var showAddressOnMapHandler: ((_ address: String?) -> Void)?
    var callPhoneNumberHandler: ((_ phoneNumber: String?) -> Void)?
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var refreshControl = UIRefreshControl()
    
    private let imageView = NBGradientImageView(frame: .zero)
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let addressView = AddressView()
    private let emailView = ContactView()
    private let phoneNumberView = ContactView()
    private let descriptionView = DescriptionView()
    private let dateLabel = UILabel()
   
    
    private var imageViewHeightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    func update(with model: NBViewModel) {
        guard let data = model.data as? ItemDetailsViewData else { return }
        
        if let imageUrlString = data.imageUrl, let imageUrl = URL(string: imageUrlString) {
            imageView.loadImage(at: imageUrl)
        }
        DispatchQueue.main.async {
            self.priceLabel.isHidden = data.price == nil
            self.addressView.isHidden = data.address == nil
            self.emailView.isHidden = data.email == nil
            self.phoneNumberView.isHidden = data.phoneNumber == nil
            self.descriptionView.isHidden = data.description == nil
            self.dateLabel.isHidden = data.createdDate == nil
            
            self.titleLabel.text = data.title
            self.priceLabel.text = data.price
            self.descriptionView.update(with: NBViewModel(data: DescriptionViewData(
                description: data.description
            )))
            self.emailView.contactByHandler = data.textToEmailHandler
            self.emailView.update(with: NBViewModel(data: ContactViewData(
                contact: data.email,
                type: .email
            )))
            self.phoneNumberView.contactByHandler = data.callPhoneNumberHandler
            self.phoneNumberView.update(with: NBViewModel(data: ContactViewData(
                contact: data.phoneNumber,
                type: .phone
            )))
            self.addressView.showAddressOnMapHandler = data.showAddressOnMapHandler
            self.addressView.update(with: NBViewModel(
                data: AddressViewData(
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
        priceLabel.isHidden = true
        addressView.isHidden = true
        emailView.isHidden = true
        phoneNumberView.isHidden = true
        descriptionView.isHidden = true
        dateLabel.isHidden = true
        
        backgroundColor = NBColor.NBMain.backgroundColor
        
        scrollView.alwaysBounceVertical = true
        scrollView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(onTopRefresh(_:)), for: .valueChanged)
        scrollView.backgroundColor = NBColor.NBMain.backgroundColor
        
        contentView.backgroundColor = NBColor.NBMain.backgroundColor
        contentView.layer.cornerRadius = ViewConstants.contentViewCornerRadius
        contentView.clipsToBounds = true
        
        titleLabel.numberOfLines = ViewConstants.titleLabelNumberOfLines
        titleLabel.font = .boldSystemFont(ofSize: ViewConstants.titleLabelFontSize)
        titleLabel.textColor = .white
        
        priceLabel.numberOfLines = ViewConstants.priceLabelNumberOfLines
        priceLabel.font = .boldSystemFont(ofSize: ViewConstants.priceLabelFontSize)
        priceLabel.textColor = .black
        
        dateLabel.numberOfLines = ViewConstants.dateLabelNumberOfLines
        dateLabel.font = .systemFont(ofSize: ViewConstants.dateLabelFontSize)
        dateLabel.textColor = .gray
        
        imageView.contentMode = .scaleAspectFill
        imageView.image = NBImage.imagePlaceholder
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
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
            vStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            
            phoneNumberView.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            
            emailView.widthAnchor.constraint(equalTo: vStack.widthAnchor)
        ])
        
    }
    
    private func endRefreshing() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
    
    @objc
    private func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else { return }
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        UIView.transition(with: self, duration: 0.25, options: [.transitionCrossDissolve], animations: {
            self.addSubview(newImageView)
        }, completion: nil)
        
    }

    @objc
    private func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else { return }
        UIView.transition(with: self, duration: 0.25, options: [.transitionCrossDissolve], animations: {
            imageView.removeFromSuperview()
        }, completion: nil)
        
    }
    
    @objc
    private func onTopRefresh(_ sender: UIRefreshControl) {
        endRefreshing()
        onTopRefresh?()
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
