//
//  DetailViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailViewController: BaseViewController<DetailView> {
    
    var post: Post?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.isToolbarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationController?.isToolbarHidden = false
    }
    
    func setUpToolBar() {
        navigationController?.isToolbarHidden = false
        
        let appearance = UIToolbarAppearance()
        // 불투명한 그림자를 한겹 쌓습니다.
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemOrange
        
        navigationController?.toolbar.scrollEdgeAppearance = appearance
        
        let heartButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: nil, action: nil)
        
        
        let barItems = [heartButton]
        
        self.toolbarItems = barItems
        
        heartButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.heartButtonTapped()
            }
            .disposed(by: disposeBag)
        
        
    }
    
    func heartButtonTapped() {
       
    
    }
    
    override func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
        let ellipsis = UIBarButtonItem(image: UIImage(systemName: CraftMate.Phrase.ellipsisIcon), style: .plain, target: nil, action: nil)
      
        navigationItem.rightBarButtonItem = ellipsis
        
        ellipsis.rx.tap
            .bind(with: self) { owner, _ in
                owner.ellipsisTapped()
            }
            .disposed(by: disposeBag)
        
    }
    
    
    func ellipsisTapped() {
        //1.
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        //2.
        let edit = UIAlertAction(title: "게시글 수정", style: .default) { _ in
            self.editButtonTapped()
        }
        let delete = UIAlertAction(title: "삭제", style: .destructive) { _ in
            self.deleteButtonTapped()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        //3.
        // HIG - cancel이 마지막 자리 권장(정해져있음)
        // 2개일 때는 왼쪽에
        alert.addAction(cancel)
        alert.addAction(edit)
        alert.addAction(delete)
        
        
        //4.
        present(alert, animated: true)
    
    }
    
    func editButtonTapped() {
        print(#function)
    }
    
    func deleteButtonTapped() {
        print(#function)
        if let postId = post?.postId {
            NetworkManager.deletePost(postId: postId)
            print("\(postId)삭제 완료")
        }
    }
    
    override func setupUI() {
        rootView.nickNameLabel.text = post?.creator.nick
        rootView.titleLabel.text = post?.title
        rootView.categoryLabel.text = post?.productId
        rootView.contentLabel.text = post?.content1
        rootView.hashTagLabel.text = post?.content
        
    }
    
}
