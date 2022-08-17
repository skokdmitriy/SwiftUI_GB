//
//  GroupView.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 07.08.2022.
//

import SwiftUI

struct GroupView: View {
    var body: some View {
        NavigationView {
            List {
                GroupCell()
                
            }
            .navigationTitle("Group")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView()
    }
}
