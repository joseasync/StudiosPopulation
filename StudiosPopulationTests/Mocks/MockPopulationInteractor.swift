//
//  MockPopulationInteractor.swift
//  StudiosPopulationTests
//
//  Created by Jose Cruz on 04/10/2024.
//

@testable import StudiosPopulation

class MockPopulationInteractor: PopulationNetworkProtocol{
    
    var population: AnyObject?
    func getPopulation<T>(dataType: StudiosPopulation.DataType, year: String) async throws -> T where T : AnyObject, T : Decodable {
                
        guard let population = population as? T else {
                    fatalError("Mocked object is not expected type \(T.self)")
        }
        return population
    }
}
