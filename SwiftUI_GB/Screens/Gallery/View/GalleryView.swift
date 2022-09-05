//
//  GalleryView.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 06.08.2022.
//

import SwiftUI
import ASCollectionView

struct GalleryView: View {
    
    @ObservedObject var viewModel: PhotoViewModel
    
    init(viewModel: PhotoViewModel) {
        self.viewModel = viewModel
    }
        
    var body: some View {
        ASCollectionView(data: viewModel.photos) { photo, context in
            return PhotosViewCell(photo: photo)
        }
        .layout {
            .grid(
                layoutMode: .fixedNumberOfColumns(3),
                itemSpacing: 8,
                lineSpacing: 8)
        }
        .onAppear {
            viewModel.fetchPhoto()
        }
    }
}

//struct GalleryView_Previews: PreviewProvider {
//    static var previews: some View {
//        GalleryView()
//    }
//}
