//
//  Property.swift
//  Not Toast
//
//  Created by Andrew Brainerd on 5/10/22.
//

import Foundation
import SwiftUI

struct Property: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var price: String
    var bedrooms: Int
    var bathrooms: Int
    var street: String
    var city: String
    var images: [String]
}
