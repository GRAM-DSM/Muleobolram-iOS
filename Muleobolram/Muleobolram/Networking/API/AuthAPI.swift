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
    
    func path() -> String {
        switch self {
        case .login:
            return "/login"
        case .signUp:
            return "/singup"
        }
    }
    
}

