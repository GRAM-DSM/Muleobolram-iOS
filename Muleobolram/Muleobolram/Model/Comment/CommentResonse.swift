//
//  CommentResonse.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/15.
//

import Foundation

struct Comment : Codable {
    var content = String()
    var name = String()
    
    init(content : String, name : String) {
        self.content = content
        self.name = name
    }
}

