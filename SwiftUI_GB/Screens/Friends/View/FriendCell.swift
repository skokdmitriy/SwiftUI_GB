//
//  Cell.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 20.07.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct FriendCell: View {
    
    let item: FriendModel
    
    var body: some View {
        CustomCell(image: item.photo50,
                   lastName: item.lastName,
                   firstName: item.firstName)
    }
}

fileprivate struct CustomCell: View {
    let image: String
    let lastName: String
    let firstName: String
    
    var body: some View {
        HStack() {
            WebImage(url: URL(string: image))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipped()
                .clipShape(Circle())
                .overlay{
                    Circle().stroke(.cyan, lineWidth: 2)
                }
                .shadow(radius: 4)
            
            Text("\(lastName) \(firstName)")
                .italic()
            Spacer()
        }
        .padding()
        .cellStyle(cornerRadius: 20, shadowColor: .gray, shadowRadius: 3)
    }
}

struct CellModifier: ViewModifier {
    let cornerRadius: CGFloat
    let shadowColor: Color
    let shadowRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(Color.white)
                            .shadow(color: shadowColor, radius: shadowRadius, x: 3, y: 3))
    }
}

extension View {
    func cellStyle (cornerRadius: CGFloat, shadowColor: Color, shadowRadius: CGFloat) -> some View {
        self.modifier(CellModifier(cornerRadius: cornerRadius, shadowColor: shadowColor, shadowRadius: shadowRadius))
    }
}

//struct Cell_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendCell()
//    }
//}
