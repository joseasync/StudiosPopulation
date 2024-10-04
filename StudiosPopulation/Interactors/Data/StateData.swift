//
//  StateData.swift
//  StudiosPopulation
//
//  Created by Jose Cruz on 03/10/2024.
//

import Foundation

class StateData: Codable{
    let data: [StatePopulationData]
    
    init(data: [StatePopulationData]) {
        self.data = data
    }
}

struct StatePopulationData: Codable {
    let idState: String
    let state: String
    let idYear: Int
    let year: String
    let population: Int
    let slugState: String
    
    enum CodingKeys: String, CodingKey {
        case idState = "ID State"
        case state = "State"
        case idYear = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugState = "Slug State"
    }
}
