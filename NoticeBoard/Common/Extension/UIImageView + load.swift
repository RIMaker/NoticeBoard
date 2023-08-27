//
//  UIImageView + load.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 27.08.2023.
//

import UIKit

extension UIImageView {
        
    func loadImage(at url: URL) {
        UIImageLoader.loader.load(url, for: self)
    }
    
    func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
}

