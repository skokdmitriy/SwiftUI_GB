//
//  GalleryView.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 06.08.2022.
//

import SwiftUI
import ASCollectionView

struct GalleryView: View {
    
    @State var dataExample = (0 ..< 30).map { $0 }
    
    var body: some View {
        ASCollectionView(data: dataExample, dataID: \.self) { item, _ in
            Color.cyan
                .overlay(Text("\(item)"))
        }
        .layout {
            .grid(
                layoutMode: .adaptive(withMinItemSize: 100),
                itemSpacing: 3,
                lineSpacing: 3,
                itemSize: .absolute(100))
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
