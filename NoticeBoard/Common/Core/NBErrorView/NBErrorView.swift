//
//  NBErrorView.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import UIKit

final class NBErrorView: NBView {
    
    private var onButtonTap: (() -> ())?
    
    private lazy var titleLabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = NBColor.NBErrorView.textColor
        lbl.font = .boldSystemFont(ofSize: 20)
        return lbl
    }()
    private lazy var button: UIButton = {
        let btn = UIButton()
        btn.isHidden = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        btn.backgroundColor = NBColor.NBErrorView.Button.backgroundColor
        btn.setTitleColor(NBColor.NBErrorView.Button.textColor, for: .normal)
        btn.addTarget(self, action: #selector(onButtonTap(_:)), for: .touchUpInside)
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func update(with model: NBViewModel) {
        guard let data = model.data as? NBErrorViewData else { return }
        
        titleLabel.text = data.title
        button.isHidden = data.button == nil
        button.setTitle(data.button?.title, for: .normal)
        
        onButtonTap = {
            data.button?.onTap()
        }
    }
    
    private func setup() {
        addSubview(titleLabel)
        addSubview(button)
        backgroundColor = NBColor.NBErrorView.backgroundColor
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 62),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc
    private func onButtonTap(_ sender: UIButton) {
        onButtonTap?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
