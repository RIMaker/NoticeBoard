//
//  String + encodeUrl.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 28.08.2023.
//

import Foundation

extension String {
    
    var encodeUrl : String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
}
