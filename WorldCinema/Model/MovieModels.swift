//
//  MovieCoverModel.swift
//  WordCinameApp
//
//  Created by Денис Большачков on 14.03.2022.
//

import Foundation

struct MovieCoverModel: Codable {
    var movieId: String
    var backgroundImage: String
    var foregroundImage: String
}


struct UserMovieModel: Codable {
    var movieId: String
    var name: String
    var description: String
    var age: String
    var poster: String
}
