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
            self.stateDidSet()
        }
    }
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = NBColor.NBMain.backgroundColor
        return view
    }()
    
    private lazy var loadingView: NBLoadingView = {
        let view = NBLoadingView()
        return view
    }()
    
    private lazy var errorView: NBErrorView = {
        let view = NBErrorView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func displayImage(fromUrl url: URL?) {
        guard let imageUrl = url else { return }
        let imageView = UIImageView()
        imageView.loadImage(at: imageUrl)
        imageView.frame = view.bounds
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        imageView.addGestureRecognizer(tap)
        UIView.transition(with: view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
            self.view.addSubview(imageView)
        }, completion: nil)
        
    }
    
    private func setup() {
        view.backgroundColor = NBColor.NBMain.backgroundColor
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        errorView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loadingView)
        view.addSubview(errorView)
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func stateDidSet() {
        switch state {
        case .content:
            showContentView()
        case .error(let error, let onTap):
            showErrorView(error: error, onTap: onTap)
        case .loading:
            showLoadingView()
        }
    }

    @objc
    private func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else { return }
        UIView.transition(with: view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
            imageView.removeFromSuperview()
        }, completion: nil)
        
    }
}

private extension NBViewController {
    
    func showLoadingView() {
        view.bringSubviewToFront(loadingView)
    }
    
}

private extension NBViewController {
    
    func showContentView() {
        view.bringSubviewToFront(contentView)
    }
    
}

private extension NBViewController {
    
    func showErrorView(error: NetworkError?, onTap: (() -> Void)?) {
        let errorButton = onTap == nil ? nil: NBErrorViewData.Button(
            title: Constants.tryAgainTitle,
            onTap: { [weak self] in
                self?.showContentView()
                onTap?()
            }
        )
        let errorTitle: String
        
        switch error {
        case .noInternetConnection, .timedOut:
            errorTitle = Constants.noInternetConnectionTitle
        default:
            errorTitle = Constants.defaultErrorTitle
        }
        let errorViewModel = NBViewModel(
            data: NBErrorViewData(
                title: errorTitle,
                button: errorButton
            )
        )
        
        errorView.update(with: errorViewModel)
        view.bringSubviewToFront(errorView)
        
        if errorButton == nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.showContentView()
            }
        }
    }
    
}
