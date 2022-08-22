//
//  GroupModel.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 21.08.2022.
//

import Foundation

struct SearchGroup: Decodable {
    let response: ResponseGroup
}

struct ResponseGroup: Decodable {
    let count: Int
    let items: [GroupModel]
}

class GroupModel: Identifiable, Decodable {
    var id = 0
    var name = ""
    var photo100 = ""

    enum CodingKeys: String, CodingKey {
        case id
        case name = "name"
        case photo100 = "photo_100"
    }
}
