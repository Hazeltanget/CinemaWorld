//
//  EpizodesMovie.swift
//  WorldCinema
//
//  Created by Денис Большачков on 22.03.2022.
//

import Foundation

struct EpisodeMovie: Codable {
    var episodeId: String
    var name: String
    var description: String
    var moviesId: String
    var director: String
    var stars: [String]
    var year: String
    var runtime: String
    var preview: String
    var images: [String]
}
