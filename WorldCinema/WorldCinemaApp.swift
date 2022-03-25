//
//  WorldCinemaApp.swift
//  WorldCinema
//
//  Created by Денис Большачков on 16.03.2022.
//

import SwiftUI

@main
struct WorldCinemaApp: App {
    @State private var isFirstTry = true
    var body: some Scene {
        WindowGroup {
            if isFirstTry {
                SignUpScreen {
                    self.isFirstTry = false
                }
            } else {
                SignInScreen()
            }
        }
        
    }
}
