//
//  Remote.swift
//  PhotoDisplay
//
//  Created by AP Aliaksandr Chekushkin on 1/6/21.
//

import SwiftUI

struct LoadingError: Error {}

final class Remote<A>: ObservableObject {
    @Published var result: Result<A, Error>? = nil
    var value: A? { try? result?.get() }
    
    let url: URL
    let transform: (Data) -> A?

    init(url: URL, transform: @escaping (Data) -> A?) {
        self.url = url
        self.transform = transform
    }

    func load(completionBlock: @escaping() -> Void = { }) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let d = data, let v = self.transform(d) {
                    self.result = .success(v)
                    completionBlock()
                } else {
                    self.result = .failure(LoadingError())
                }
            }
        }.resume()
    }
}


