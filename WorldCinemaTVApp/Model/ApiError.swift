//
//  ApiError.swift
//  WorldCinema
//
//  Created by Денис Большачков on 16.03.2022.
//

import Foundation


enum APError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
}
