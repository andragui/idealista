//
//  PropertyEntities.swift
//  iOSCodeChallenge
//
//  Created by Andres Aguirre Juarez on 6/10/21.
//

import Foundation

class PropertyEntities {
    var propertyEntities: [PropertyEntity] = []
    init(_ dto: IDResultsDTO) {
        for result in dto.elementList {
            propertyEntities.append(PropertyEntity(result))
        }
    }
}
