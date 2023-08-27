//
//  NBCollectionViewModel.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import UIKit

typealias NBCollectionViewCell = UICollectionViewCell & NBCollectionViewCellInput

struct NBCollectionViewModel: Equatable {
    
    let id: String
    let data: AnyHashable
    let cellType: NBCollectionViewCell.Type
    
    static func == (lhs: NBCollectionViewModel, rhs: NBCollectionViewModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.data == rhs.data
    }
}
