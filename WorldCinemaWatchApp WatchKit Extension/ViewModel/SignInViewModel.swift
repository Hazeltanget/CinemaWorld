//
//  SignInViewModel.swift
//  WorldCinemaWatchApp WatchKit Extension
//
//  Created by Денис Большачков on 22.03.2022.
//

import Foundation

class SignInViewModel: ObservableObject {
    
    @Published var alert: AlertItem?
    
    func authUser(model: PostUserDataForAuth) -> Bool{
        var forRet = false
        
        Api().authUser(model: model) { [self] result in
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
