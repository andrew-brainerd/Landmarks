//
//  ModelData.swift
//  Not Toast
//
//  Created by Andrew Brainerd on 5/8/22.
//

import Foundation

struct GetPropertiesResponse: Codable {
    var properties: [Property]
}

struct GetPropertyResponse: Codable {
    var property: Property
}

var localProperties: [Property] = load("propertyData.json")

var apiBaseUrl = "https://toast-server.herokuapp.com"

func fetchProperties() async -> [Property] {
    guard let url = URL(string: "\(apiBaseUrl)/api/properties")
    else {
        print("Invalid URL")
        return []
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decodedResponse = try JSONDecoder().decode(GetPropertiesResponse.self, from: data)
            return decodedResponse.properties
        } catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError)")
        }
    } catch {
        print("Invalid data")
    }
    
    return []
}

func fetchProperty(propertyId: String) async -> Property? {
    guard let url = URL(string: "\(apiBaseUrl)/api/properties/\(propertyId)")
    else {
        print("Invalid URL")
        return nil
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decodedResponse = try JSONDecoder().decode(GetPropertyResponse.self, from: data)
            return decodedResponse.property
        } catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError)")
        }
    } catch {
        print("Invalid data")
    }
    
    return nil
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle: \n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
