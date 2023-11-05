//
//  IdentifiableProtocol.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation
import UIKit

protocol IdentifiableProtocol {
    static func getIdentifier() -> String
}

extension IdentifiableProtocol {
    static var name: String {
        return String(describing: self)
    }

    static func getIdentifier() -> String {
        return self.name
    }
}
