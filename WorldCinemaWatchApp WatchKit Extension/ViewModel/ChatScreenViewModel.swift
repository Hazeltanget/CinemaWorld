//
//  ChatScreenViewModel.swift
//  WorldCinemaWatchApp WatchKit Extension
//
//  Created by Денис Большачков on 24.03.2022.
//

import Foundation

class ChatScreenViewModel: ObservableObject {
    @Published var chats: [Chat]?
    @Published var alert: AlertItem?
    
    init() {
        getChats()
    }
    
    func getChats() {
        Api().getUserChats { result in
            switch result {
            case .success(let chats):
                DispatchQueue.main.async { [self] in
                    self.chats = chats
                }
                break
                
            case .failure(let error):
                switch error {
                    case .invalidData :
                    DispatchQueue.main.async { [self] in
                        alert = AlertContext.invalidData
                    }
                case .invalidURL:
                    DispatchQueue.main.async { [self] in
                        alert = AlertContext.invalidURL
                    }
                case .unableToComplete:
                    DispatchQueue.main.async { [self] in
                        alert = AlertContext.unableToComplete
                    }
                case .invalidResponse:
                    DispatchQueue.main.async { [self] in
                        alert = AlertContext.invalidResponse
                    }
                }
                break
            }
        }
    }
}
