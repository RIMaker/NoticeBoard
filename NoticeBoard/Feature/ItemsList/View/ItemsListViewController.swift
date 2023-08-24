//
//  ItemsListViewController.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import UIKit

final class ItemsListViewController: NBViewController {
    
    var output: ItemsListViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()

        output?.viewShown()
    }
    
    private func setupViews() {
        
    }
    
    private func setupConstraints() {
        
    }
    
}

//MARK: ItemsListViewInput
extension ItemsListViewController: ItemsListViewInput {
    
    func setup() {
        setupViews()
        setupConstraints()
    }
    
    func refreshViews() {
       
    }
 
}

