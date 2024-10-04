//
//  StateViewControllerTests.swift
//  StateViewControllerTests
//
//  Created by Jose Cruz on 03/10/2024.
//

import XCTest
@testable import StudiosPopulation

@MainActor
final class StateViewControllerTests: XCTestCase {

    var sut: StateViewController!
    var mockPopulationInteractor: MockPopulationInteractor!
    
    
    override func setUp () {
        super.setUp()
        sut = StateViewController()
        mockPopulationInteractor = MockPopulationInteractor()
        sut.populationInteractor = mockPopulationInteractor
    }

    override func tearDown() {
        sut = nil
        mockPopulationInteractor = nil
        super.tearDown()
    }
    
    func testFetchPopulation_withValidObject() async {
        let samplePopulationData = StatePopulationData(
            idState: "01000US",
            state: "Ohio",
            idYear: 2222,
            year: "2022",
            population: 99999,
            slugState: "ohio"
        )
        let stateData = StateData(data: [samplePopulationData])
        mockPopulationInteractor.population = stateData
        
        await sut.fetchPopulation()
        
        XCTAssertNotNil(sut.populationView.populationList)
        XCTAssertEqual(sut.populationView.populationList.count, 1)
        XCTAssertEqual(sut.yearsFilter.count, 2)
        XCTAssertEqual(sut.populationView.populationList[0].year, "2022")
        XCTAssertEqual(sut.populationView.populationList[0].population, samplePopulationData.population)
        XCTAssertEqual(sut.populationView.populationList[0].location, samplePopulationData.state)
    }
    
    func testFetchPopulation_withEmptyData() async {
        let emptyStateData = StateData(data: [])
        mockPopulationInteractor.population = emptyStateData
        
        await sut.fetchPopulation()
        
        XCTAssertNotNil(sut.populationView.populationList)
        XCTAssertEqual(sut.populationView.populationList.count, 0)
    }
}
