//
//  AuthAPI.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/13.
//

import Foundation

enum AuthAPI : API {
    case login //signIn login
    case signUp // signUp
    case auth
    
    func path() -> String {
        switch self {
        case .login:
            return "/login"
        case .signUp:
            return "/singup"
        case .auth :
            return "/auth"
        }
    }
    
}

