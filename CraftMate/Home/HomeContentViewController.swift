//
//  HomeContentViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/22/24.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeContentViewController: BaseViewController<HomeView> {
    
    let disposeBag = DisposeBag()
    
    let viewModel = HomeViewModel()
    
    // 나중에 Rx로 수정
    var items = ["홈데코", "공예", "리폼", "아이들", "주방", "기타"]
    var sortImages = ["홈", "비즈", "비즈", "홈", "주방", "비즈"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네트워크 요청 실행
        viewModel.fetchPosts()
        bind()
    }
    //
    //    func bind() {
    //        rootView.floatingButton.floatingButton
    //            .rx
    //            .tap
    //            .bind(with: self) { owner, _ in
    //                owner.navigationController?.pushViewController(WritePostViewController(), animated: true)
    //            }
    //            .disposed(by: disposeBag)
    //    }
    //}
    
    func bind() {
           rootView.floatingButton.floatingButton
               .rx
               .tap
               .bind(with: self) { owner, _ in
                   owner.navigationController?.pushViewController(WritePostViewController(), animated: true)
               }
               .disposed(by: disposeBag)
   
         
       }
   
       func bindTableView() {
           // ViewModel의 posts와 TableView 바인딩
           viewModel.posts
               .bind(to: rootView.tableView.rx.items(cellIdentifier: HomeTableViewCell.identifier, cellType: HomeTableViewCell.self)) { row, post, cell in
                   cell.configure(with: post)
               }
               .disposed(by: disposeBag)
       }
   
       
   }
   
   
   
extension HomeContentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(title: items[indexPath.row], image: sortImages[indexPath.row])
        
        
        return cell
    }
}
