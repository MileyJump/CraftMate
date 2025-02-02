//
//  LoginModel.swift
//  CraftMate
//
//  Created by 최민경 on 8/17/24.
//

import Foundation

struct LoginModel: Decodable {
    let id: String
    let email: String
    let nick: String
    let profile: String?
    let access: String
    let refresh: String
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case email, nick
        case profile = "profileImage"
        case access = "accessToken"
        case refresh = "refreshToken"
    }
}
