//
//  FriendModel.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 17.08.2022.
//

import Foundation

struct FriendsContainer: Decodable {
    let response: FriendsResponse
}

struct FriendsResponse: Decodable {
    let count: Int
    let items: [FriendModel]
}

struct FriendModel: Decodable, Identifiable {
    
    let id: Int
    let firstName: String
    let lastName: String
    let photo50: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case photo50 = "photo_50"
    }
}
