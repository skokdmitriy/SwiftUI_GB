//
//  Cell.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 20.07.2022.
//

import SwiftUI

struct Cell: View {
    var body: some View {
        ScrollView {
            CustomCell(image: "person.circle", title: "Stark")
            CustomCell(image: "person.circle", title: "Hawk")
            CustomCell(image: "person.circle", title: "Montana")
            CustomCell(image: "person.circle", title: "Parker")
        }
    }
}

struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        Cell()
    }
}

struct CustomCell: View {
    let image: String
    let title: String
    
    var body: some View {
        HStack() {
            Image(systemName: image)
            Text(title)
                .italic()
            Spacer()
        }
        .padding()
        .modifier(CellModifier(cornerRadius: 20, shadowColor: .gray, shadowRadius: 3))
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

