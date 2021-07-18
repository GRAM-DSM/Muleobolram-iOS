//
//  Community.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/17.
//

import Foundation

struct Section : Codable {
    var myName = String()
    var title = String()
    var id = Int()
    
    init(myName : String, title : String, id : Int) {
        self.myName = myName
        self.title = title
        self.id = id
    }
}
