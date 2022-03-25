//
//  UserDefaultsUtils.swift
//  WorldCinemaWatchApp WatchKit Extension
//
//  Created by Денис Большачков on 24.03.2022.
//

import Foundation

class UserDefaultsUtils {
    let userdefaults = UserDefaults.standard
    
    func saveToken(token: Int) {
        UserDefaults().set(token, forKey: "token")
    }
    
    func getToken() -> Int {
        return userdefaults.integer(forKey: "token")
    }
}
