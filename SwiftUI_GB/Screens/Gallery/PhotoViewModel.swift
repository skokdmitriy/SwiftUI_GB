//
//  PhotoViewModel.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 22.08.2022.
//

import Foundation
import SwiftUI

class PhotoViewModel: ObservableObject {
    
    let apiPhoto: PhotoService
    let friends: FriendModel
    
    @Published var photos: [InfoPhotoFriend] = []
    
    init(apiPhoto: PhotoService, friends: FriendModel) {
        self.friends = friends
        self.apiPhoto = apiPhoto
    }
    
    public func fetchPhoto() {
        apiPhoto.loadPhoto(idFriend: friends.id) { [weak self] result in
            guard let self = self else { return }
            self.photos = result
            
        }
    }
}
