//
//  PostUserDataForAuth.swift
//  WorldCinemaWatchApp WatchKit Extension
//
//  Created by Денис Большачков on 24.03.2022.
//

import Foundation

struct PostUserDataForReg {
    var email: String
    var password: String
    var firstName: String
    var lastName: String
}

struct PostUserDataForAuth {
    var email: String
    var password: String
}

struct PostUserDataForAuthRecieveData: Codable {
    var token: Int
}
