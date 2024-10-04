//
//  NationViewControllerTests.swift
//  NationViewControllerTests
//
//  Created by Jose Cruz on 03/10/2024.
//

import XCTest
@testable import StudiosPopulation

@MainActor
final class NationViewControllerTests: XCTestCase {

    var sut: NationViewController!
    var mockPopulationInteractor: MockPopulationInteractor!
    
    
    override func setUp () {
        super.setUp()
        mockPopulationInteractor = MockPopulationInteractor()
        sut = NationViewController(networkInteractor: mockPopulationInteractor)
    }

    override func tearDown() {
        sut = nil
        mockPopulationInteractor = nil
        super.tearDown()
    }
    
    func testFetchPopulation_withValidObject() async {
        let samplePopulationData = NationPopulationData(
            idNation: "01000US",
            nation: "United States",
            idYear: 2222,
            year: "2022",
            population: 99999,
            slugNation: "united-states"
        )
        let nationData = NationData(data: [samplePopulationData])
        mockPopulationInteractor.population = nationData
        
        await sut.fetchPopulation()
        
        XCTAssertNotNil(sut.populationView.populationList)
        XCTAssertEqual(sut.populationView.populationList.count, 1)
        XCTAssertEqual(sut.populationView.populationList[0].year, "2022")
        XCTAssertEqual(sut.populationView.populationList[0].population, samplePopulationData.population)
    }
    
    func testFetchPopulation_withEmptyData() async {
        let emptyNationData = NationData(data: [])
        mockPopulationInteractor.population = emptyNationData
        
        await sut.fetchPopulation()
        
        XCTAssertNotNil(sut.populationView.populationList)
        XCTAssertEqual(sut.populationView.populationList.count, 0)
    }
}
