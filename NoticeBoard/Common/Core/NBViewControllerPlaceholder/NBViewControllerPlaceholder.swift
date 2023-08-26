//
//  NBViewControllerPlaceholder.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import UIKit

final class NBViewControllerPlaceholder: UIViewController {
    
    private var onButtonTap: (() -> ())?
    
    private lazy var titleLabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = NBColor.NBViewControllerPlaceholder.textColor
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    private lazy var button: UIButton = {
        let btn = UIButton()
        btn.isHidden = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        btn.backgroundColor = NBColor.NBViewControllerPlaceholder.Button.backgroundColor
        btn.setTitleColor(NBColor.NBViewControllerPlaceholder.Button.textColor, for: .normal)
        btn.addTarget(self, action: #selector(onButtonTap(_:)), for: .touchUpInside)
        return btn
    }()
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func update(with model: NBViewControllerPlaceholderModel) {
        titleLabel.text = model.title
        button.isHidden = model.button == nil
        button.setTitle(model.button?.title, for: .normal)
        
        onButtonTap = {
            model.button?.onTap()
        }
    }
    
    private func setup() {
        view.addSubview(titleLabel)
        view.addSubview(button)
        view.backgroundColor = NBColor.NBViewControllerPlaceholder.backgroundColor
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: -32)
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
