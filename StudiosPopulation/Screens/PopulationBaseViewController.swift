//
//  PopulationBaseViewController.swift
//  StudiosPopulation
//
//  Created by Jose Cruz on 04/10/2024.
//

import UIKit

class PopulationBaseViewController: UIViewController {

    let populationView = PopulationView()
    var populationInteractor: PopulationNetworkProtocol = PopulationInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(populationView)
        
        populationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            populationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            populationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            populationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            populationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
