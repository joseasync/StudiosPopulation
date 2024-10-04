//
//  PopulationView.swift
//  StudiosPopulation
//
//  Created by Jose Cruz on 04/10/2024.
//

import UIKit

protocol PopulationDelegate {
    func fetchPopulation() async
}

class PopulationView: UIView {
    
    private let populationTableview = UITableView()
    private let populationCellName = "tableCellName"
    var populationList: [Population] = []
    var populationViewDelegate: PopulationDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("NSCoder has not been implemented")
    }
    
    private func setup() {
        backgroundColor = UIColor.clear
        configureTableView()
    }
    
    private func configureTableView() {
        populationTableview.register(PopulationTableViewCell.self, forCellReuseIdentifier: populationCellName)
        populationTableview.dataSource = self
        populationTableview.delegate = self
        populationTableview.backgroundColor = UIColor.clear
        populationTableview.allowsSelection = false
        
        addSubview(populationTableview)
        populationTableview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            populationTableview.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            populationTableview.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            populationTableview.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            populationTableview.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
    }
    
    func updatePopulationList(with population: [Population]) {
        populationList = population
        DispatchQueue.main.async {
            self.populationTableview.reloadData()
        }
    }
}


extension PopulationView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return populationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if populationList.count == 0 { return PopulationTableViewCell() }
        
        let populationItem = populationList[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: populationCellName, for: indexPath) as? PopulationTableViewCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.3)
        cell.set(with: populationItem)
        return cell
    }
}
