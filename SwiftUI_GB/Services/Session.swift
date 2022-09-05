//
//  Session.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 17.08.2022.
//

import Foundation

class Session: ObservableObject {
    
    static let shared = Session()
    
    private init() {}
    
    @Published var isAuthorized: Bool = false
    @Published var token: String?
    @Published var userId: String?
    @Published var versionApi = "5.131"
    @Published var clientId = "8012272"
    
}
