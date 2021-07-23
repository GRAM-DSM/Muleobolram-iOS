//
//  File.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/23.
//

import Foundation

struct Community : Codable {
    var myName = String()
    var title = String()
    var content = String()
    var id = Int()
    
    init(myName : String, title : String, content : String, id : Int) {
        self.myName = myName
        self.title = title
        self.content = content
        self.id = id
    }
}
