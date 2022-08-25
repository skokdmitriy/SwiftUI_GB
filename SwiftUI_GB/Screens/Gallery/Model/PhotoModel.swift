//
//  PhotoModel.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 22.08.2022.
//

import Foundation
import SwiftUI

struct PhotoFriends: Codable {
    let response: ResponsePhoto
}

struct ResponsePhoto: Codable {
    let count: Int
    let items: [InfoPhotoFriend]
}

class InfoPhotoFriend: Codable, Identifiable {
    var id = 0
    var text = ""
    var sizes: [Size]
    
    enum CodingKeys: String, CodingKey {
        case text
        case sizes
    }
}

struct Size: Codable {
    let url: String
    let type: String
    let width: Int
    let height: Int
}

