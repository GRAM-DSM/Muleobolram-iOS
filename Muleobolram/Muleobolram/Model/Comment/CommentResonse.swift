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
    
    init(commentId : Int, content : String) {
        self.commentId = commentId
        self.content = content
    }
}

