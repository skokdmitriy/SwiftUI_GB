//
//  FriendsView.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 07.08.2022.
//

import SwiftUI

struct FriendsView: View {
    let friend: [People] = [
        People(name: "Stark", image: "Stark"),
        People(name: "Hawk", image: "Hawk"),
        People(name: "Montana", image: "Montana"),
        People(name: "Parker", image: "Parker")
    ]
    
    var body: some View {
        friendsView
    }
}


struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}

extension FriendsView {
    var listFriends: some View {
        List {
            ForEach(friend) { item in
                NavigationLink(destination: Text(item.name)) {
                    FriendCell(item: item)
                }
            }
            .navigationBarTitle(Text("Friends"))
            .listStyle(.grouped)
        }
    }
    
    var friendsView: some View {
        TabView {
            NavigationView {
                listFriends
            }
            .tabItem {
                Text("Friends")
                Image(systemName: "person")
            }
            
            NavigationView {
                GroupView()
            }
            .tabItem {
                Text("Group")
                Image(systemName: "star")
            }
        }
    }
}
