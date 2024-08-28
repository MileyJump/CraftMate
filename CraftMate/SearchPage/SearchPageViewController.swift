//
//  SearchPageViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import UIKit

final class SearchPageViewController: BaseViewController<SearchPageView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupNavigationBar() {
        navigationItem.titleView = rootView.searchBar
        navigationItem.backButtonTitle = ""
    }
    
    override func configureView() {
        rootView.collectionView.delegate = self
        rootView.collectionView.dataSource = self
        
        rootView.collectionView.register(OrderCollectionViewCell.self, forCellWithReuseIdentifier: OrderCollectionViewCell.identifier)
    }
}

extension SearchPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCollectionViewCell.identifier, for: indexPath) as? OrderCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
   
}
