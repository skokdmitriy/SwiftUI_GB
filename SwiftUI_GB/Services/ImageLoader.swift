//
//  ImageLoader.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 21.08.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoader {
    
    var image: WebImage
    
    init(@ViewBuilder image: () -> WebImage) {
        self.image = image()
    }
    
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 50, height: 50)
            .clipped()
            .clipShape(Circle())
            .overlay{
                Circle().stroke(.cyan, lineWidth: 2)
            }
            .shadow(radius: 4)
    }
}
