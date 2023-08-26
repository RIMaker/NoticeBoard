//
//  Advertisement.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import Foundation

struct Advertisement: Decodable {
    let id: String?
    let title: String?
    let price: String?
    let location: String?
    let imageUrl: String?
    let createdDate: String?
}
