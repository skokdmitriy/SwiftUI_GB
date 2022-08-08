//
//  GalleryView.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 06.08.2022.
//

import SwiftUI

struct GalleryView: View {
    let image: People
    
    var body: some View {
        Image(image.image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 250, height: 250)
            .clipped()
            .clipShape(Circle())
            .overlay{
                Circle().stroke(.cyan, lineWidth: 2)
            }
            .shadow(radius: 4)
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView(image: People.init(name: "Hawk", image: "Hawk")
)
    }
}
