//
//  AdvertisementDetails.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import Foundation

struct AdvertisementDetails: Decodable {
    let id: String?
    let title: String?
    let price: String?
    let location: String?
    let imageUrl: URL?
    let createdDate: Date?
    let description: String?
    let email: String?
    let phoneNumber: String?
    let address: String?
}
