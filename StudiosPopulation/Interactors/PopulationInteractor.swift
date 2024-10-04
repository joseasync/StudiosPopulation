//
//  PopulationInteractor.swift
//  StudiosPopulation
//
//  Created by Jose Cruz on 03/10/2024.
//

import Foundation

protocol PopulationNetworkProtocol {
    func getPopulation<T: Decodable & AnyObject>(dataType: DataType, year: String) async throws -> T
}

class PopulationInteractor: PopulationNetworkProtocol {
    
    let cache = NSCache<NSString, AnyObject>()
    private let baseURL = "https://datausa.io/api/data"
    let decoder = JSONDecoder()
    
    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getPopulation<T: Decodable & AnyObject>(dataType: DataType, year: String) async throws -> T {
        
        let cacheKey = NSString(string: "\(dataType.rawValue)-\(year)")
        if let cachedPopulation = cache.object(forKey: cacheKey) as? T { return cachedPopulation}
        
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "drilldowns", value: dataType.rawValue),
            URLQueryItem(name: "measures", value: "Population"),
            URLQueryItem(name: "year", value: year == "All" ? nil : year)
        ]
        
        guard let url = urlComponents?.url else {
            throw SPError.invalidData
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw SPError.invalidResponse
        }
        
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            cache.setObject(decodedData, forKey: cacheKey)
            return decodedData
            
        } catch {
            throw SPError.invalidData
        }
    }
}

