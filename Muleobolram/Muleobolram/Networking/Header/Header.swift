//
//  Header.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/08.
//

import Foundation
import Alamofire

struct Token {
    static var _token : String?
    static var token :String?{
        get{
            _token = UserDefaults.standard.string(forKey: "token")
            return _token
        }
        
        set(newToken){
            UserDefaults.standard.setValue(newToken, forKey: "token")
            _token = UserDefaults.standard.string(forKey: "token")
        }
    }
    
    static var _refrsehToken : String?
    static var refreshToken : String?{
        get {
            _refrsehToken = UserDefaults.standard.string(forKey: "refreshToken")
            return _refrsehToken
        }
        set(newRefreshToken) {
            UserDefaults.standard.setValue(newRefreshToken, forKey: "refreshToken")
            _refrsehToken = UserDefaults.standard.string(forKey: "refreshToken")
        }
    }
    static func tokenRemove(){
        token = nil
    }
}

enum Header {
    case token, tokenIsEmpty, refreshToken
    
    func header() -> HTTPHeaders {
        
        guard let token = Token.token else {
            return ["Content-Type" : "application/json"]
        }
        
        guard let refreshToken = Token.refreshToken else {
            return ["Content-Type" : "application/json"]
        }
        
        switch self {
        case .token:
            return HTTPHeaders(["Authorization" : "Bearer " + token, "Content-Type" : "application/json"])
            
        case .refreshToken :
            return HTTPHeaders(["Authorization" : "Bearer " + token, "Content-Type" : "application/json"])
            
        case .tokenIsEmpty:
            return ["Content-Type" : "application/json"]
        }
    }
}
