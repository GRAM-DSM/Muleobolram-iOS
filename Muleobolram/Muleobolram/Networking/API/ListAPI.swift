//
//  ListAPI.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/14.
//

import Foundation

enum ListAPI : API {
    case List
    case ListDelete(_ id : Int)
    case SeeList(_ id : Int)
    
    func path() -> String {
        switch self {
        case .List:
            return "/post"
        case .ListDelete(let id) :
            return "/post/\(id)"
        case .SeeList(let id) :
            return "/post/\(id)"
        }
    }
    
    
}
