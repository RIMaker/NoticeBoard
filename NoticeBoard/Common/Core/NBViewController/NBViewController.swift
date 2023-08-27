//
//  NBViewController.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 25.08.2023.
//

import UIKit

class NBViewController: UIViewController {
    
    var state: NBViewControllerState = .content {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.stateDidSet()
            }
        }
    }
    
    private lazy var activityIndicator: NBActivityIndicator = {
        let indicator = NBActivityIndicator()
        return indicator
    }()
    
    private lazy var viewControllerPlaceholder: NBViewControllerPlaceholder = {
        let vcPlaceholder = NBViewControllerPlaceholder()
        return vcPlaceholder
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideActivityIndicator()
        hideViewControllerPlaceholder()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = NBColor.NBMain.backgroundColor
        activityIndicator.view.translatesAutoresizingMaskIntoConstraints = false
        viewControllerPlaceholder.view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(activityIndicator.view)
        addChild(activityIndicator)
        activityIndicator.didMove(toParent: self)
        
        view.addSubview(viewControllerPlaceholder.view)
        addChild(viewControllerPlaceholder)
        viewControllerPlaceholder.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            activityIndicator.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            activityIndicator.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityIndicator.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityIndicator.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            viewControllerPlaceholder.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewControllerPlaceholder.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewControllerPlaceholder.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewControllerPlaceholder.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func stateDidSet() {
        switch state {
        case .content:
            hideActivityIndicator()
            hideViewControllerPlaceholder()
        case .error(let placeholderModel, let error, let onTap):
            hideActivityIndicator()
            if let placeholderModel {
                showViewControllerPlaceholder(with: placeholderModel)
            } else if let error {
                showViewControllerPlaceholder(error: error, onTap: onTap)
            } else {
                hideViewControllerPlaceholder()
            }
        case .loading:
            hideViewControllerPlaceholder()
            showActivityIndicator()
        }
    }
}

extension NBViewController {
    
    private func showActivityIndicator() {
        activityIndicator.view.isHidden = false
        activityIndicator.startAnimating()
        view.bringSubviewToFront(activityIndicator.view)
    }
    
    private func hideActivityIndicator() {
        activityIndicator.view.isHidden = true
        activityIndicator.stopAnimating()
        view.sendSubviewToBack(activityIndicator.view)
    }
}

extension NBViewController {
    
    private func showViewControllerPlaceholder(with model: NBViewControllerPlaceholderModel) {
        var modelCopy = model
        if let modelOnTap = modelCopy.button?.onTap {
            modelCopy.button?.onTap = { [weak self] in
                self?.hideViewControllerPlaceholder()
                modelOnTap()
            }
        }
        
        viewControllerPlaceholder.update(with: modelCopy)
        viewControllerPlaceholder.view.isHidden = false
        view.bringSubviewToFront(viewControllerPlaceholder.view)
        
        if model.button == nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.state = .content
            }
        }
    }
    
    private func showViewControllerPlaceholder(error: NetworkError, onTap: (() -> Void)?) {
        switch error {
        case .noInternetConnection, .timedOut:
            showViewControllerPlaceholder(with: .init(
                title: Constants.noInternetConnectionTitle,
                button: .init(
                    title: Constants.tryAgainTitle,
                    onTap: {
                        onTap?()
                    }
                )
            ))
        case .noData:
            showViewControllerPlaceholder(with: .init(
                title: Constants.noDataTitle,
                button: nil
                )
            )
        default:
            showViewControllerPlaceholder(with: .init(
                title: Constants.defaultErrorTitle,
                button: .init(
                    title: Constants.tryAgainTitle,
                    onTap: {
                        onTap?()
                    }
                )
            ))
        }
    }
    
    private func hideViewControllerPlaceholder() {
        viewControllerPlaceholder.view.isHidden = true
        view.sendSubviewToBack(viewControllerPlaceholder.view)
    }
}
