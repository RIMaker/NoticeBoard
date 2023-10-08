//
//  NBLoadingView.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import UIKit

final class NBLoadingView: NBView {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityInd = UIActivityIndicatorView()
        activityInd.translatesAutoresizingMaskIntoConstraints = false
        activityInd.color = NBColor.NBLoadingView.IndicatorColor.indicatorColor
        activityInd.style = .large
        activityInd.startAnimating()
        return activityInd
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func update(with model: NBViewModel) {
        
    }
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
    
    private func setup() {
        addSubview(activityIndicator)
        backgroundColor = NBColor.NBLoadingView.BackgroundColor.backColor
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


