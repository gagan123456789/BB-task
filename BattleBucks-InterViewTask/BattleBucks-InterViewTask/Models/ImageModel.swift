//
//  ImageModel.swift
//  BattleBucks-InterViewTask
//
//  Created by Gagandeep Sidhu on 20/10/24.
//

import Foundation

// Model representing an image, conforming to Identifiable and Decodable protocols
struct ImageModel: Identifiable, Decodable {
    let id: Int
    let albumId: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
