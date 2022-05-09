//
//  ModelData.swift
//  Landmarks
//
//  Created by Andrew Brainerd on 5/8/22.
//

import Foundation

struct GetLandmarksResponse: Codable {
    var landmarks: [Landmark]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

var localLandmarks: [Landmark] = load("landmarkData.json")

func loadFromApi() async -> [Landmark] {
    guard let url = URL(string: "http://10.0.0.41:5000/api/landmarks")
    else {
        print("Invalid URL")
        return []
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decodedResponse = try JSONDecoder().decode(GetLandmarksResponse.self, from: data)
            return decodedResponse.landmarks
        } catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError)")
        }
    } catch {
        print("Invalid data")
    }
    
    return []
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
