//
//  SignUpViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//

import UIKit
import RxSwift
import RxCocoa


class LoginViewController: BaseViewController<LoginView> {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        rootView.loginButton
            .rx
            .tap
            .bind(with: self) { owner, _ in
                let email = owner.rootView.emailTextField.text ?? ""
                let password = owner.rootView.passwordTextField.text ?? ""
                
                NetworkManager.shared.createLogin(email: email, password: password) { value, isEnabled  in
                    if isEnabled {
                        print("로그인 가능?")
                        owner.changeRootViewController(MainTabBarController())
                    }
                }
            }
            .disposed(by: disposeBag)
        
        rootView.signUpButton
            .rx
            .tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(SignUpViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}
