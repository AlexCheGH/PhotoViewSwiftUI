//
//  PhotoModel.swift
//  PhotoDisplay
//
//  Created by AP Aliaksandr Chekushkin on 1/6/21.
//

import Foundation

struct Photo: Codable, Identifiable {
    let id, author: String
    let width, height: Double
    let url, downloadURL: String

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
