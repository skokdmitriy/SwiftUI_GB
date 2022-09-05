//
//  PhotosViewCell.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 23.08.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct PhotosViewCell: View {
    
    var photo: InfoPhotoFriend
    
    var body: some View {
        GeometryReader { proxy in
            WebImage(url: URL(string: photo.sizes.last?.url ?? ""))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100, alignment: .center)
                .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
        }
    }
}

//struct PhotosViewCell_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotosViewCell()
//    }
//}
