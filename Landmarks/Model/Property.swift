//
//  Property.swift
//  Landmarks
//
//  Created by Andrew Brainerd on 5/10/22.
//

import Foundation
import SwiftUI

struct Property: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var state: String
    var description: String
}
