//
//  NBActivityIndicator.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import UIKit

final class NBActivityIndicator: UIViewController {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityInd = UIActivityIndicatorView()
        activityInd.translatesAutoresizingMaskIntoConstraints = false
        activityInd.color = NBColor.NBActivityIndicator.IndicatorColor.indicatorColor
        activityInd.style = .large
        activityInd.startAnimating()
        return activityInd
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
    
    private func setup() {
        view.addSubview(activityIndicator)
        view.backgroundColor = NBColor.NBActivityIndicator.BackgroundColor.backColor
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


