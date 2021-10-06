//
//  DetailDTO.swift
//  iOSCodeChallenge
//
//  Created by Andres Aguirre Juarez on 5/10/21.
//

import Foundation

struct DetailDTO: Codable {
    let adid: String
    let price: Int
    let extendedPropertyType, operation, propertyComment: String
    let multimedia: MultimediaDTO?
}

// MARK: - Multimedia
struct MultimediaDTO: Codable {
    let images: [ImageDTO]?
}

// MARK: - Image
struct ImageDTO: Codable {
    let url: String
}
