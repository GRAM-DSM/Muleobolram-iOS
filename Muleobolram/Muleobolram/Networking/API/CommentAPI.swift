//
//  CommentAPI.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/14.
//

import Foundation

enum CommentAPI : API {
    case commentList(_ id: Int)
    case commentWrite(_ id: Int)
    
    func path() -> String {
        switch self {
        case .commentWrite(let id):
            return "/comment?post_id=\(id)"
        case .commentList(let id):
            return "/comment?post_id=\(id)"
        }
    }
    
    
}
