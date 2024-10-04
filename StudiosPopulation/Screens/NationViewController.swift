//
//  NationViewController.swift
//  StudiosPopulation
//
//  Created by Jose Cruz on 03/10/2024.
//

import UIKit

@MainActor
class NationViewController: PopulationBaseViewController {

    init(networkInteractor: PopulationNetworkProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.populationInteractor = networkInteractor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populationView.populationViewDelegate = self
        setup()
    }
    
    func setup(){
        Task{
            await fetchPopulation()
        }
    }
}

extension NationViewController: PopulationDelegate {
    
    func fetchPopulation() async {
        do {
            
            guard let populationInteractor else { return }
            let nationData: NationData = try await populationInteractor.getPopulation(dataType: .nation, year: "All")
            
            let populationList = nationData.data.map { nationPopulation in
                Population(
                    id: nationPopulation.idNation,
                    location: nationPopulation.nation,
                    idYear: nationPopulation.idYear,
                    year: nationPopulation.year,
                    population: nationPopulation.population,
                    slugLocation: nationPopulation.slugNation
                )}
            populationView.updatePopulationList(with: populationList)
        } catch let customError as SPError{
            presentAlertOnMainThread(alertTitle: "Error", message: customError.rawValue, buttonTitle: "Ok")
        } catch {
            presentAlertOnMainThread(alertTitle: "Error", message: "Something went wrong. Please try again.", buttonTitle: "Ok")
        }
    }
}
