//
//  PopulationTableViewCell.swift
//  StudiosPopulation
//
//  Created by Jose Cruz on 03/10/2024.
//

import UIKit
class PopulationTableViewCell: UITableViewCell {
    private let idLabel = UILabel()
    private let locationLabel = UILabel()
    private let yearLabel = UILabel()
    private let populationLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.3)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    
    private func setupViews() {
        contentView.addSubview(idLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(populationLabel)
        
        idLabel.font = UIFont.systemFont(ofSize: 14)
        idLabel.textColor = .secondaryLabel
        
        locationLabel.font = UIFont.systemFont(ofSize: 14)
        locationLabel.textColor = .secondaryLabel
        
        yearLabel.font = UIFont.systemFont(ofSize: 14)
        yearLabel.textColor = .secondaryLabel
        
        populationLabel.font = UIFont.systemFont(ofSize: 16)
        populationLabel.textColor = .label
        populationLabel.textAlignment = .right
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        populationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            idLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: idLabel.leadingAnchor),
            locationLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 4),
            
            yearLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            yearLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 4),
            yearLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            populationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            populationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        ])
    }
    
    func set(with model: Population) {
        idLabel.text = "ID: \(model.id)"
        locationLabel.text = "Location: \(model.location)"
        yearLabel.text = "Year: \(model.year)"
        populationLabel.text = "Population: \(model.population)"
    }
}
