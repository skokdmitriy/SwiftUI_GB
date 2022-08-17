//
//  People.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 07.08.2022.
//

import Foundation
import SwiftUI

class People: Identifiable {
    var id: UUID = UUID()
    var name: String
    var image: String
    
    internal init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}

//let peoples = ["Stark","Hawk","Montana","Parker"]
