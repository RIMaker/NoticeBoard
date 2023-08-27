//
//  NBCollectionViewModel.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import UIKit

typealias NBCollectionViewCell = UICollectionViewCell & NBCollectionViewCellInput

struct NBCollectionViewModel {
    
    let data: NBCollectionViewModelData
    let cellType: NBCollectionViewCell.Type
    var id: String {
        return String(describing: cellType)
    }
    
}

protocol NBCollectionViewModelData {}
