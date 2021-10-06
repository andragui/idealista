//
//  StarButton.swift
//  iOSCodeChallenge
//
//  Created by Andres Aguirre Juarez on 6/10/21.
//

import UIKit

class StarButton: UIButton {
    func setOn(_ isOn: Bool) {
        let systemNameImage = isOn ? "star.fill" : "star"
        setImage(UIImage(systemName: systemNameImage), for: .normal)
    }
}
