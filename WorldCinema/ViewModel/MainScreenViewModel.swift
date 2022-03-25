//
//  MainScreenViewModel.swift
//  WorldCinema
//
//  Created by Денис Большачков on 16.03.2022.
//

import Foundation
import SwiftUI

class MainScreenViewModel: ObservableObject {
    private var movierRepo: MovieRepository
    
    @Published var headerMovie: MovieCoverModel? = nil
    @Published var headerImage: Image? = nil
    @Published var currentItem: DataForHeaderNav
    @Published var itemsCompilation = [MovieModel]()
    @Published var alert: AlertItem?
    @Published var bottomBarItems: [BottomBarItem] = [BottomBarItem(img: Image("Vector"), title: "Главное"), BottomBarItem(img: Image("Vector-1"), title: "Подборка"), BottomBarItem(img: Image("Vector-2"), title: "Коллекции"), BottomBarItem(img: Image("Vector-3"), title: "Профиль")]
    @Published var lastFilm: UserMovieModel? = nil
    
    
    var dataForHeader = [DataForHeaderNav(name: "В тренде", filter: "inTrend"), DataForHeaderNav(name: "Новое", filter: "mew"), DataForHeaderNav(name: "Для вас", filter: "forMe")]
    
    var address_for_photos = "http://cinema.areas.su/up/images/"
    
    
    init() {
        movierRepo = MovieRepository()
        
        currentItem = dataForHeader[0]
        getHeaderImage()
        getItemsCompilation(filter: "inTrend")
        getLastUserMovie()
    }
    
    func getHeaderImage() {
        let model = movierRepo.getCoverMovie()
        headerMovie = model
        
        self.headerImage = ImageConverter().getImageFromWeb(strUlr: address_for_photos + model!.foregroundImage)
    }
    
    func getSubImage() {
        let model = movierRepo.getCoverMovie()
        
        self.headerImage = ImageConverter().getImageFromWeb(strUlr: address_for_photos + model!.foregroundImage)
    }
    
    func getItemsCompilation(filter: String){
        itemsCompilation = [MovieModel]()
        
        movierRepo.getCompilationMovies(filter: filter) { [self] result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.itemsCompilation = items
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
    
    func getLastUserMovie() {
        movierRepo.getUserMovies(filter: "lastView") { [self] result in
            switch result {
            case .success(let item):
                DispatchQueue.main.async {
                    lastFilm = item[0]
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

enum FilterState {
    case new
    case inTrend
    case forMe
}
