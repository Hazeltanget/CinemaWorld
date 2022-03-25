//
//  SignUpViewModel.swift
//  WorldCinema
//
//  Created by Денис Большачков on 16.03.2022.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var userRepository: UserRepository = UserRepository()
    @Published var alert: AlertItem?
    
    func registerUser(model: PostUserDataForReg) {
        userRepository.postUser(userData: model)
    }
}
