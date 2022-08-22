//
//  ContainerView.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 17.08.2022.
//

import SwiftUI

struct ContainerView: View {
    
    @ObservedObject var session = Session.shared
    
    var body: some View {
        NavigationView {
            HStack {
                VKLoginWebView()
                NavigationLink(destination: TabBarView(), isActive: $session.isAuthorized) {
                    EmptyView()
                }
            }
        }
    }
}
