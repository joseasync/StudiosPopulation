//
//  SPError.swift
//  StudiosPopulation
//
//  Created by Jose Cruz on 03/10/2024.
//

import Foundation

enum SPError: String, Error {
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response. Please try again."
    case invalidData = "Invalid data. Please try again."
}
