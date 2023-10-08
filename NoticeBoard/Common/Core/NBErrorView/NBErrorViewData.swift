//
//  NBErrorViewData.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import Foundation

struct NBErrorViewData: NBViewData {
    
    let title: String
    let button: Button?
    
    struct Button {
        let title: String
        let onTap: () -> ()
    }
}
