//
//  PropertyDetailEntity.swift
//  iOSCodeChallenge
//
//  Created by Andres Aguirre Juarez on 5/10/21.
//

import Foundation

struct PropertyDetailEntity {
    let price: Int?
    let extendedPropertyType: String?
    let operation: String?
    let propertyComment: String?
    let multimedia: MultimediaEntity?
    
    init(_ dto: DetailDTO) {
        self.price = dto.price
        self.extendedPropertyType = dto.extendedPropertyType
        self.operation = dto.operation
        self.propertyComment = dto.propertyComment
        self.multimedia = MultimediaEntity(dto.multimedia)
    }
}

// MARK: - Multimedia
struct MultimediaEntity {
    var images: [ImageEntity] = []
    init(_ dto: MultimediaDTO?) {
        guard let dto = dto, let images = dto.images else { return }
        for image in images {
            self.images.append(ImageEntity(image))
        }
    }
}

// MARK: - Image
struct ImageEntity {
    let url: String
    init(_ dto: ImageDTO) {
        self.url = dto.url
    }
}
