//
//  MovieScreenViewModel.swift
//  WorldCinema
//
//  Created by Денис Большачков on 21.03.2022.
//

import Foundation

    class MovieScreenViewModel: ObservableObject {
        private var movieRepo: MovieRepository
        
        static var address_for_video = "http://cinema.areas.su/up/video/"
        static var address_for_images = "http://cinema.areas.su/up/images/"
    
        @Published var idMovie: Int? = nil {
            willSet {
                currentMovie = movieRepo.getMovie(idMovie: newValue!)
                episodes = movieRepo.getEpisodesMovie(movieId: newValue!)
            }
        }
        @Published var currentMovie: MovieModel? = nil
        @Published var episodes: [EpisodeMovie]? = nil
        
        init() {
            self.movieRepo = MovieRepository()
        }
    }

