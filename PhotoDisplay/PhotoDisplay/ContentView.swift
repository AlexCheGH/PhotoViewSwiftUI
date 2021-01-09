//
//  ContentView.swift
//  PhotoDisplay
//
//  Created by AP Aliaksandr Chekushkin on 1/6/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var items = Remote(
        url: URL(string: "https://picsum.photos/v2/list")!,
        transform: { try? JSONDecoder().decode([Photo].self, from: $0) }
    )
    
    
    
    @State var text: String? = nil
    
    var body: some View {
        NavigationView {
            if let photos = items.value {
                List(photos) { photo in
                    let url = URL(string: photo.downloadURL)!
                    NavigationLink(photo.author, destination: PhotoView(url))
                }
            } else {
                ProgressView()
                    .onAppear(perform: {
                        items.load()
                    })
            }
            
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
