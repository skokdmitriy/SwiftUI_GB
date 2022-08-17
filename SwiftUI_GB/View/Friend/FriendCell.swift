//
//  Cell.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 20.07.2022.
//

import SwiftUI

struct FriendCell: View {
    let item: People
    
    var body: some View {
        CustomCell(image: item.image, title: item.name)
    }
}

struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        FriendCell(item: People.init(name: "Hawk", image: "Hawk"))
    }
}

struct CustomCell: View {
    let image: String
    let title: String
    
    var body: some View {
        HStack() {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipped()
                .clipShape(Circle())
                .overlay{
                    Circle().stroke(.cyan, lineWidth: 2)
                }
                .shadow(radius: 4)
            
            Text(title)
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

