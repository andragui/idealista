//
//  PropertyEntity.swift
//  iOSCodeChallenge
//
//  Created by Andres Aguirre Juarez on 5/10/21.
//

import Foundation

class PropertyEntity {
    let propertyCode: String?
    let thumbnail: String?
    let price: Int?
    let propertyType: String?
    let multimedia: IDResultMultimediaDTO?
    let detailUrl: String?
    let operation: String?
    var isFavourite: Bool = false
    
    init(_ dto: IDResultDTO) {
        self.propertyCode = dto.propertyCode
        self.thumbnail = dto.thumbnail
        self.price = dto.price
        self.propertyType = dto.propertyType
        self.multimedia = dto.multimedia
        self.detailUrl = dto.detailUrl
        self.operation = dto.operation
    }
    
    func setIsFavourite(_ newValue: Bool) {
        self.isFavourite = newValue
    }
}
