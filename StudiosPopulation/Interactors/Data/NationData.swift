//
//  NationData.swift
//  StudiosPopulation
//
//  Created by Jose Cruz on 03/10/2024.
//

import Foundation

class NationData: NSObject, Codable {
    var data: [NationPopulationData]
    
    init(data: [NationPopulationData]) {
            self.data = data
    }
}

struct NationPopulationData: Codable {
    let idNation: String
    let nation: String
    let idYear: Int
    let year: String
    let population: Int
    let slugNation: String

    enum CodingKeys: String, CodingKey {
        case idNation = "ID Nation"
        case nation = "Nation"
        case idYear = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugNation = "Slug Nation"
    }
}
