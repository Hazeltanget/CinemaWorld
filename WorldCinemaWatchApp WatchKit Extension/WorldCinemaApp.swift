//
//  WorldCinemaApp.swift
//  WorldCinemaWatchApp WatchKit Extension
//
//  Created by Денис Большачков on 22.03.2022.
//

import SwiftUI

 @main
struct WorldCinemaApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                MainScreen()
                    .onAppear {                        
                        UserDefaultsUtils().saveToken(token: 761377)
                    }
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
