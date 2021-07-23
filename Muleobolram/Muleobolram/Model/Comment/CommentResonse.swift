//
//  CommentResonse.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/15.
//

import Foundation

struct Comment : Codable {
    var commentId = Int()
    var content = String()
    var name = String()
    
    init(commentId : Int, content : String, name : String) {
        self.commentId = commentId
        self.content = content
        self.name = name
    }
}

