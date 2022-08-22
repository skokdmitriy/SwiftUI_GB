//
//  FriendModelView.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 16.08.2022.
//

import Foundation
import SwiftUI

class FriendViewModel: ObservableObject {
    
    let apiFriend: FriendsService
    
    @Published var friends: [FriendModel] = []
    
    init (apiFriend: FriendsService) {
        self.apiFriend = apiFriend
    }
    
    public func fetchFriends () {
        apiFriend.loadFriend() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(friends):
                self.friends = friends.response.items
            case let .failure(error):
                print(error)
            }
        }
    }
}
