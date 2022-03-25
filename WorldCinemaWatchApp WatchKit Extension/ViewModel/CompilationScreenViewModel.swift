//
//  CompilationScreenViewModel.swift
//  WorldCinemaWatchApp WatchKit Extension
//
//  Created by Денис Большачков on 24.03.2022.
//

import Foundation


class CompilationScreenViewModel: ObservableObject{
    @Published var movies: [MovieModel]?
    @Published var alert: AlertItem?
    
    init() {
        getMovies()
    }
    
    func getMovies() {
        Api().getCompilationMovies { [self] result in
            switch result {
            case .success(let item):
                DispatchQueue.main.async {
                    movies = item
                }
                
                break
                
            case .failure(let error):
                switch error {
                case .invalidData :
                    alert = AlertContext.invalidData
                case .invalidURL:
                    alert = AlertContext.invalidURL
                case .unableToComplete:
                    alert = AlertContext.unableToComplete
                case .invalidResponse:
                    alert = AlertContext.invalidResponse
                }
                break
            }
        }
    }
}
