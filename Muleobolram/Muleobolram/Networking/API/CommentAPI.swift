//
//  CommentAPI.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/14.
//

import Foundation

enum CommentAPI : API {
    case CommentList(_ id: Int)
    case CommentWrite
    
    func path() -> String {
        switch self {
        case .CommentWrite:
            return "/comment/"
        case .CommentList(let id):
            return "/comment/\(id)"
        }
    }
    
    
}
