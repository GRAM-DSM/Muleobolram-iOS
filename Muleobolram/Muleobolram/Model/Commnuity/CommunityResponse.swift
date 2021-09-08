//
//  File.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/23.
//

import Foundation

struct Community : Codable {
    var title = String()
    var content = String()
    var id_pk = Int()
    var created_at = String()
    var name = String()
    
    init(title : String, content : String, id_pk : Int, created_at : String, name : String) {
        self.title = title
        self.content = content
        self.id_pk = id_pk
        self.created_at = created_at
        self.name = name
    }
}
