//
//  NBCollectionView.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import UIKit

class NBCollectionView: UIView {
    
    var onTopRefresh: (() -> ())?
    
    private var models: [NBCollectionViewModel] = []
    private var registerIds: Set<String> = []
    
    private lazy var refreshControl = UIRefreshControl()
    private lazy var collectionView: UICollectionView = {
        let collView = setupCollectionView()
        return collView
    }()
    
    init() {
        super.init(frame: .zero)
        
        addSubview(collectionView)
        setUpContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpContent() {
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(onTopRefresh(_:)), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func setupCollectionView() -> UICollectionView {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = ViewConstants.minimumLineSpacing
        layout.minimumInteritemSpacing = ViewConstants.minimumInteritemSpacing
        layout.sectionInset = ViewConstants.sectionInset
        let colView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colView.backgroundColor = NBColor.NBMain.backgroundColor
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.delegate = self
        colView.dataSource = self
        return colView

    }
    
    func display(models: [NBCollectionViewModel]) {
        
        self.models = models
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func endRefreshing() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
    
    private func cell(indexPath: IndexPath, model: NBCollectionViewModel) -> UICollectionViewCell {
        if !registerIds.contains(model.id) {
            registerIds.insert(model.id)
            
            collectionView.register(
                model.cellType,
                forCellWithReuseIdentifier: model.id
            )
        }
        
        return collectionView.dequeueReusableCell(
            withReuseIdentifier: model.id,
            for: indexPath
        )
    }
                                 
    @objc
    private func onTopRefresh(_ sender: UIRefreshControl) {
        endRefreshing()
        onTopRefresh?()
    }
}

//MARK: UICollectionViewDelegate
extension NBCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.item < models.count else { return UICollectionViewCell() }
        
        let model = models[indexPath.item]
        let cell = cell(indexPath: indexPath, model: model)

        if let cell = cell as? NBCollectionViewCellInput {
            cell.update(with: model.data)
        }
        
        return cell
    }
    
}

extension NBCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = (collectionView.frame.width - layout.minimumInteritemSpacing - layout.sectionInset.left - layout.sectionInset.right) / 2
        let heightPerItem = ViewConstants.heightPerItem
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
}

fileprivate enum ViewConstants {
    static let minimumLineSpacing: CGFloat = 16
    static let minimumInteritemSpacing: CGFloat = 10
    static let sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    static let heightPerItem: CGFloat = UIScreen.main.bounds.height / 3
}
