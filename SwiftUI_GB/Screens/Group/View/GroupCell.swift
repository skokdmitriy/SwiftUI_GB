//
//  GroupCell.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 07.08.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct GroupCell: View {
    
    let item: GroupModel
    
    var body: some View {
        CustomGroupCell(image: item.photo100, name: item.name)
    }
}

fileprivate struct CustomGroupCell: View {
    let image: String
    let name: String
    
    var body: some View{
        HStack() {
            WebImage(url: URL(string: image))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(.cyan, lineWidth: 2))
                .shadow(radius: 2)
            
            Text(name)
                .font(.headline)
            
            Spacer()
        }
    }
}

//struct GroupCell_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupCell()
//    }
//}
