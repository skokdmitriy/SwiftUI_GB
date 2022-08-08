//
//  GroupCell.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 07.08.2022.
//

import SwiftUI

struct GroupCell: View {
    
    var body: some View {
        HStack {
            Image(systemName: "star")
                .resizable()
                .padding(10.0)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(.cyan, lineWidth: 2))
                .shadow(radius: 2)
            
            Text("Star")
                .font(.headline)
            
            Spacer()
        }
    }
}

struct GroupCell_Previews: PreviewProvider {
    static var previews: some View {
        GroupCell()
    }
}
