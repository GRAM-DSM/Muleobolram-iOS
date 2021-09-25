//
//  AuthAPI.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/13.
//

import Foundation

enum AuthAPI : API {
    case login // 로그인
    case signUp // 회원가입
    case auth   // id 중복 확인
    
    func path() -> String {
        switch self {
        case .login:
            return "/login"
        case .signUp:
            return "/signup"
        case .auth :
            return "/auth"
        }
    }
    
}

