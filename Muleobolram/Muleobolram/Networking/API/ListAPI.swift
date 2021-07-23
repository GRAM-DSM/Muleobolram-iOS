//
//  ListAPI.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/14.
//

import Foundation

enum ListAPI : API {
    case listWrite
    case listDelete(_ id : Int)
    case seeList
    
    func path() -> String {
        switch self {
        case .listWrite:
            return "/post"
        case .listDelete(let id) :
            return "/post/\(id)"
        case .seeList :
            return "/post"
        }
    }
    
    
}
