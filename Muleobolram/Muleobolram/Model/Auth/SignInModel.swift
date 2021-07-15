//
//  Sign.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/14.
//

import Foundation

struct SignInModel : Codable {
    
    var acess_token = String()
    var refresh_token = String()
    
    
    init(acess_token : String, refresh_token : String) {
        self.acess_token = acess_token
        self.refresh_token = refresh_token
    }
}
