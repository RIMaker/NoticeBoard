//
//  UIImageView + load.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 27.08.2023.
//

import UIKit

extension UIImageView {
    
    func loadWithoutCaching(url: URL, completion: (()->())?) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        completion?()
                    }
                }
            }
        }
    }
        
    func loadImage(at url: URL) {
        UIImageLoader.loader.load(url, for: self)
    }
    
    func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
}

