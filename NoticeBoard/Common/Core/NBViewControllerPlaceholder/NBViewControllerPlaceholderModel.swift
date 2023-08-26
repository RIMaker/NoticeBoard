//
//  NBViewControllerPlaceholderModel.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import Foundation

struct NBViewControllerPlaceholderModel {
    
    var title: String
    var button: Button?
    
    struct Button {
        var title: String
        var onTap: () -> ()
    }
}
