//
//  TextCellData.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 30.09.2023.
//

import Foundation

struct TextCellData: NBCollectionViewCellData {
    enum Font {
        case regular
        case bold
    }
    enum Color {
        case black
        case gray
    }
    let text: String?
    let font: Font
    let fontSize: CGFloat
    let color: Color
}
