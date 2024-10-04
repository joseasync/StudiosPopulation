//
//  StateViewController.swift
//  StudiosPopulation
//
//  Created by Jose Cruz on 03/10/2024.
//

import UIKit

class StateViewController: PopulationBaseViewController {
    
    var selectedYear: String = "All"
    var yearsFilter: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populationView.populationViewDelegate = self
        Task{
            await fetchPopulation()
        }
    }
    
    func configureMenuButton() {
        
        let menuItems = yearsFilter.map { year in
            UIAction(title: year, handler: { _ in
                self.selectedYear = year
                Task{
                    await self.fetchPopulation()
                }
            })
        }
        
        let menu = UIMenu(title: "Filter by Year", children: menuItems)
        let menuButton = UIBarButtonItem(title: "Year", image: UIImage(systemName: "line.horizontal.3.decrease.circle"), primaryAction: nil, menu: menu)
        navigationItem.rightBarButtonItem = menuButton
    }
}

extension StateViewController: PopulationDelegate {
    
    func fetchPopulation() async {
        
        do {
            let stateData: StateData = try await populationInteractor.getPopulation(dataType: .state, year: selectedYear)
            
            let populationList = stateData.data.map { statePopulation in
                Population(
                    id: statePopulation.idState,
                    location: statePopulation.state,
                    idYear: statePopulation.idYear,
                    year: statePopulation.year,
                    population: statePopulation.population,
                    slugLocation: statePopulation.slugState
                )}
            
            if yearsFilter.isEmpty {
                yearsFilter.append(selectedYear)
                yearsFilter.append(contentsOf: Array(Set(populationList.map { $0.year })).sorted().reversed())
                configureMenuButton()
            }
            populationView.updatePopulationList(with: populationList)
        } catch let customError as SPError{
            presentAlertOnMainThread(alertTitle: "Error", message: customError.rawValue, buttonTitle: "Ok")
        } catch {
            presentAlertOnMainThread(alertTitle: "Error", message: "Something went wrong. Please try again.", buttonTitle: "Ok")
        }
    }
    
}
