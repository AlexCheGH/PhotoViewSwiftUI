//
//  PhotoView.swift
//  PhotoDisplay
//
//  Created by AP Aliaksandr Chekushkin on 1/8/21.
//

import SwiftUI

struct PhotoView: View {
    
    @State var checker = false
    @ObservedObject var image: Remote<UIImage>
    
    init(_ url: URL) {
        image = Remote(url: url, transform: { UIImage(data: $0) })
    }
    
    var imageOrPlaceholder: Image {
        image.value.map(Image.init) ?? Image(systemName: "")
    }
    
    var body: some View {
        elemntToDisplay
            .onAppear(perform: {
                image.load {
                    self.checker = true
                }
            })
    }
    
    
    
    var elemntToDisplay: some View {
        Group {
            if checker {
                imageOrPlaceholder
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
            } else {
                ProgressView()
            }
        }
    }
}
