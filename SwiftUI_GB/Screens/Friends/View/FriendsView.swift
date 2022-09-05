//
//  FriendsView.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 07.08.2022.
//

import SwiftUI

struct FriendsView: View {
    
    @ObservedObject var viewModel: FriendViewModel
    
    init(viewModel: FriendViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        listFriends
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView(viewModel: FriendViewModel(apiFriend: FriendAPI()))
    }
}

private extension FriendsView {
    var listFriends: some View {
        List(viewModel.friends.sorted(by: { $0.lastName < $1.lastName })) { friend in
            
            NavigationLink(destination: GalleryView(viewModel: PhotoViewModel(apiPhoto: PhotoApi(), friends: friend))) {
                FriendCell(item: friend)
            }
        }
        .onAppear {
            viewModel.fetchFriends()
        }
//        .navigationTitle(Text("Friends"))
    }
}
