//
//  CompilationMovieModel.swift
//  WordCinameApp
//
//  Created by Денис Большачков on 15.03.2022.
//

import Foundation


struct MovieModel: Codable {
    var movieId: String
    var name: String
    var description: String
    var age: String
    var images: [String]
    var poster: String
    var tags: [TagModel]
}

struct TagModel: Codable {
    var idTags: String
    var tagName: String
}
