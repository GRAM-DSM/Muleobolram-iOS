//
//  Add.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/18.
//

import Foundation

struct Add : Codable {
    var title = String()
    var detail = String()
    
    init(title : String, detail : String){
        self.title = title
        self.detail = detail
    }
}
