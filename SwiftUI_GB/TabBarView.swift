//
//  TabBarView.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 17.08.2022.
//

import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        TabView {
            
            FriendsView(viewModel: FriendViewModel(apiFriend: FriendAPI()))
                .navigationBarTitle("")
                .tabItem {
                    Image(systemName: "person")
                    Text("Friends")
                }
            GroupView(viewModel: GroupViewModel(apiGroup: GroupAPI()))
                .navigationBarTitle("")
                .tabItem {
                    Image(systemName: "star")
                    Text("Group")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
