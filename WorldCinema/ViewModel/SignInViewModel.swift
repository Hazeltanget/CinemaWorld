//
//  SignInViewModel.swift
//  WorldCinema
//
//  Created by Денис Большачков on 16.03.2022.
//

import Foundation
import SwiftUI

@MainActor class SignInViewModel: ObservableObject {
    @Published var userRepository: UserRepository = UserRepository()
    @Published var alert: AlertItem?
    
    func authUser(model: PostUserDataForAuth) -> Bool{
        var forRet = false
        
        userRepository.authUser(model: model) { [self] result in
            switch result {
            case .success(let model ):
                forRet = true
                UserDefaultsUtils().saveToken(token: model.token)
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
        
        return forRet
    }
}

struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text
    var dismissButton: Alert.Button?
}

enum AlertContext {
    static let invalidEmail = AlertItem(title: Text("Invalid data"), message: Text("Your email don't correct"), dismissButton: .default(Text("Ok")))
    
    static let invalidURL       = AlertItem(title: Text("Server Error"),
                                            message: Text("There is an error trying to reach the server. If this persists, please contact support."),
                                            dismissButton: .default(Text("Ok")))
    
    static let unableToComplete = AlertItem(title: Text("Server Error"),
                                            message: Text("Unable to complete your request at this time. Please check your internet connection."),
                                            dismissButton: .default(Text("Ok")))
    
    static let invalidResponse  = AlertItem(title: Text("Server Error"),
                                            message: Text("Invalid response from the server. Please try again or contact support."),
                                            dismissButton: .default(Text("Ok")))
    
    static let invalidData      = AlertItem(title: Text("Server Error"),
                                            message: Text("The data received from the server was invalid. Please try again or contact support."),
                                            dismissButton: .default(Text("Ok")))
}
