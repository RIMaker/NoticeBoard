//
//  ItemDetailsViewData.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 27.08.2023.
//

import Foundation

struct ItemDetailsViewData: NBViewData {
    let showAddressOnMapHandler: ((_ address: String?) -> Void)?
    let callPhoneNumberHandler: ((_ phoneNumber: String?) -> Void)?
    let textToEmailHandler: ((_ phoneNumber: String?) -> Void)?
    let title: String?
    let price: String?
    let location: String?
    let imageUrl: String?
    let createdDate: String?
    let description: String?
    let email: String?
    let phoneNumber: String?
    let address: String?
}
