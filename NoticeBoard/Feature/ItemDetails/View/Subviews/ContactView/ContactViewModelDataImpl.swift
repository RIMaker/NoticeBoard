//
//  ContactViewModelDataImpl.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 28.08.2023.
//

import Foundation

struct ContactViewModelDataImpl: ContactViewModelData {
    enum ContactType {
        case email
        case phone
    }
    let contact: String?
    let type: ContactType
}
