//
//  UIView + makeScale.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 28.08.2023.
//

import UIKit

extension UIView {
    
    func makeScale(_ sx: CGFloat, _ sy: CGFloat, completion: (()->Void)? = nil) {
        UIView.animate(withDuration: 0.2, delay: 0) {
            self.transform = CGAffineTransformMakeScale(sx, sy)
        } completion: { isCompleted in
            if isCompleted {
                completion?()
            }
        }
    }
}
