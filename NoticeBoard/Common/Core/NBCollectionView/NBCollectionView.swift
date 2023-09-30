//
//  NBCollectionView.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 26.08.2023.
//

import UIKit

class NBCollectionView: UIView {
    
    var onTopRefresh: (() -> ())?
    var didSelectItemAt: ((_ indexPath: IndexPath) -> ())?
    
    private var models: [NBCollectionViewModel] = []
    private var registerIds: Set<String> = []
    
    private lazy var refreshControl = UIRefreshControl()
    private lazy var collectionView: UICollectionView = {
        let collView = setupCollectionView()
        return collView
    }()
    
    private let spacing: CGFloat
    private let columns: Int
    private let cellsScalingEffectIsEnable: Bool
    
    init(
        spacing: CGFloat = 16,
        columns: Int = 1,
        cellsScalingEffectIsEnable: Bool = true
    ) {
        self.spacing = spacing
        self.columns = columns
        self.cellsScalingEffectIsEnable = cellsScalingEffectIsEnable
        super.init(frame: .zero)
        
        addSubview(collectionView)
        setUpContent()
    }
    
    func display(models: [NBCollectionViewModel]) {
        
        self.models = models
        self.collectionView.reloadData()
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
        let layout = setupCollectionViewLayout()
        let colView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colView.backgroundColor = NBColor.NBMain.backgroundColor
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.delegate = self
        colView.dataSource = self
        return colView

    }
    
    private func setupCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0/CGFloat(columns)),
            heightDimension: .estimated(30)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
 
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(30)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: columns
        )
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(
            top: spacing,
            leading: spacing,
            bottom: spacing,
            trailing: spacing
        )

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout

    }
    
    private func endRefreshing() {
        self.refreshControl.endRefreshing()
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        didSelectItemAt?(indexPath)
        
        if cellsScalingEffectIsEnable {
            cell.makeScale(0.95, 0.95, completion: {
                cell.makeScale(1, 1)
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if cellsScalingEffectIsEnable {
            guard let cell = collectionView.cellForItem(at: indexPath) else { return }
            
            cell.makeScale(0.95, 0.95)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if cellsScalingEffectIsEnable {
            guard let cell = collectionView.cellForItem(at: indexPath) else { return }
            
            cell.makeScale(1, 1)
        }
    }
    
}
