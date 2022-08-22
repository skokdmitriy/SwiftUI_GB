//
//  GroupView.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 07.08.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct GroupView: View {
    @ObservedObject var viewModel: GroupViewModel
    
    init(viewModel: GroupViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
            listGroups
    }
}

//struct GroupView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupView()
//    }
//}

private extension GroupView {
    var listGroups: some View {
        List(viewModel.groups.sorted(by: {$0.name < $1.name})) { group in
            GroupCell(item: group)
        }
        .onAppear(perform: viewModel.fetchGroups)
    }
}
