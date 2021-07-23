//
//  CommentAPI.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/14.
//

import Foundation

enum CommentAPI : API {
    case CommentList(_ id: Int)
    case CommentWrite(_ id: Int)
    
    func path() -> String {
        switch self {
        case .CommentWrite(let id):
            return "/comment/\(id)"
        case .CommentList(let id):
            return "/comment/\(id)"
        }
    }
    
    
}
