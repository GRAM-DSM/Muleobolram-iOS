//
//  AuthAPI.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/13.
//

import Foundation

enum AuthAPI : API {
    case Login
    case SignUp
    
    func path() -> String {
        switch self {
        case .Login:
            return "/Login"
        case .SignUp:
            return "/Singup"
        }
    }
    
}

