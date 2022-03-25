//
//  MainScreenViewModel.swift
//  WorldCinemaTVApp
//
//  Created by Денис Большачков on 25.03.2022.
//

import Foundation

class MainScreenViewModel: ObservableObject {
    @Published var inTrendCompilation = [MovieModel]()
    @Published var newCompilation = [MovieModel]()
    @Published var forYouCompilation = [MovieModel]()
    
    @Published var alert: AlertItem?
    
    var address_for_photos = "http://cinema.areas.su/up/images/"
    
    private var movieRepo = MovieRepository()
    
    init() {
        getInTrendCompilation()
        getNewCompilation()
        getForMeCompilation()
        
    }
    
    func getInTrendCompilation(){
        inTrendCompilation = [MovieModel]()
        
        movieRepo.getCompilationMovies(filter: "inTrend") { [self] result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.inTrendCompilation = items
                }
                break
                
            case .failure(let error):
                switch error {
                case .invalidData :
                    DispatchQueue.main.async {
                        alert = AlertContext.invalidData
                    }
                case .invalidURL:
                    DispatchQueue.main.async {
                        alert = AlertContext.invalidURL
                    }
                case .unableToComplete:
                    DispatchQueue.main.async {
                        alert = AlertContext.unableToComplete
                    }
                case .invalidResponse:
                    DispatchQueue.main.async {
                        alert = AlertContext.invalidResponse
                    }
                }
                break
            }
        }
    }
    
    func getNewCompilation(){
        newCompilation = [MovieModel]()
        
        movieRepo.getCompilationMovies(filter: "new") { [self] result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.newCompilation = items
                }
                break
                
            case .failure(let error):
                switch error {
                case .invalidData :
                    DispatchQueue.main.async {
                        alert = AlertContext.invalidData
                    }
                case .invalidURL:
                    DispatchQueue.main.async {
                        alert = AlertContext.invalidURL
                    }
                case .unableToComplete:
                    DispatchQueue.main.async {
                        alert = AlertContext.unableToComplete
                    }
                case .invalidResponse:
                    DispatchQueue.main.async {
                        alert = AlertContext.invalidResponse
                    }
                }
                break
            }
        }
    }
    
    
    func getForMeCompilation(){
        forYouCompilation = [MovieModel]()
        
        movieRepo.getCompilationMovies(filter: "forMe") { [self] result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.forYouCompilation = items
                }
                break
                
            case .failure(let error):
                switch error {
                case .invalidData :
                    DispatchQueue.main.async {
                        alert = AlertContext.invalidData
                    }
                case .invalidURL:
                    DispatchQueue.main.async {
                        alert = AlertContext.invalidURL
                    }
                case .unableToComplete:
                    DispatchQueue.main.async {
                        alert = AlertContext.unableToComplete
                    }
                case .invalidResponse:
                    DispatchQueue.main.async {
                        alert = AlertContext.invalidResponse
                    }
                }
                break
            }
        }
    }
}
 
