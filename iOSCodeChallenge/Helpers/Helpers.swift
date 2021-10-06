//
//  Helpers.swift
//  iOSCodeChallenge
//
//  Created by Andres Aguirre Juarez on 30/9/21.
//

import Foundation
import UIKit

class Helpers {
    class func getImage(multimedia: IDResultMultimediaDTO?, completion: @escaping (UIImage?, Error?) -> Void) {
        guard let multimedia = multimedia,
              let firstImageURL = multimedia.images.first?.url else { return }
        URLSession.shared.dataTask(with: URL(string: firstImageURL)!) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                DispatchQueue.main.sync { completion(nil, error) }
                return
            }
            DispatchQueue.main.sync { completion(image, nil) }
        }.resume() 
    }
    
    class func getSpecificImage(imageUrl: String, completion: @escaping (UIImage?, Error?) -> Void) {
        URLSession.shared.dataTask(with: URL(string: imageUrl)!) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                DispatchQueue.main.sync { completion(nil, error) }
                return
            }
            DispatchQueue.main.sync { completion(image, nil) }
        }.resume()
    }
    
    class func typeOfProperty(forOperation operation: String?, andPropertyType propertyType: String?) -> String {
        guard let operation = operation, let typology = propertyType else { return "Se ha producido un error" }
        
        switch (operation, typology) {
        case ("sale", "flat"):
            return NSLocalizedString("on_sale_flat", comment: "")
        case ("rent", "flat"):
            return NSLocalizedString("on_rent_flat", comment: "")
        case ("sale", "penthouse"):
            return NSLocalizedString("on_sale_penthouse", comment: "")
        case ("rent", "penthouse"):
            return NSLocalizedString("on_rent_penthouse", comment: "")
        case ("sale", "studio"):
            return NSLocalizedString("on_sale_studio", comment: "")
        case ("rent", "studio"):
            return NSLocalizedString("on_rent_studio", comment: "")
        case ("sale", "chalet"):
            return NSLocalizedString("on_sale_chalet", comment: "")
        case ("rent", "chalet"):
            return NSLocalizedString("on_rent_chalet", comment: "")
        case ("sale", "duplex"):
            return NSLocalizedString("on_sale_duplex", comment: "")
        case ("rent", "duplex"):
            return NSLocalizedString("on_rent_duplex", comment: "")
        default: return ""
        }
    }
}
