//
//  NBImage.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 28.08.2023.
//

import UIKit

struct NBImage {
    static var imagePlaceholder: UIImage? {
        return UIImage(named: "ImagePlaceholder", in: .main, with: nil)
    }
    
    static var emailIcon: UIImage? {
        return UIImage(systemName: "envelope.fill")
    }
    
    static var phoneIcon: UIImage? {
        return UIImage(systemName: "phone.fill")
    }
}
