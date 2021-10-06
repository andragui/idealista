//
//  DetailViewModel.swift
//  iOSCodeChallenge
//
//  Created by Andres Aguirre Juarez on 6/10/21.
//

import Foundation

struct DetailViewModel {
    let entity: PropertyDetailEntity
    var configuration: PropertyDetailConfiguration
    init(_ entity: PropertyDetailEntity, configuration: PropertyDetailConfiguration) {
        self.entity = entity
        self.configuration = configuration
    }
    
    var propertyTitle: String {
        Helpers.typeOfProperty(forOperation: entity.operation,
                               andPropertyType: entity.extendedPropertyType).capitalized
    }
    
    var price: String {
        displayCurrentLocaleCurrency(entity.price) +
            displayAdditionalInformationForRent(forOperation: entity.operation)
    }
    
    var descriptionLabel: String {
        entity.propertyComment ?? ""
    }
    
    var multimedia: MultimediaEntity? {
        entity.multimedia
    }
    
    var isFavourite: Bool {
        configuration.propertyEntity.isFavourite
    }
    
    func displayCurrentLocaleCurrency(_ price: Int?) -> String {
        guard let price = price else {
            return "0"
        }
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let priceString = currencyFormatter.string(from: NSNumber(value: price))
        return priceString ?? String(price)
    }
    
    func displayAdditionalInformationForRent(forOperation operation: String?) -> String {
        if operation == "rent" {
            return NSLocalizedString("by_month", comment: "")
        }
        return ""
    }
    
    func toggleFavourite() {
        configuration.propertyEntity.isFavourite.toggle()
    }
}
