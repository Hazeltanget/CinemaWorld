//
//  SignUpScreen.swift
//  WorldCinema
//
//  Created by Денис Большачков on 16.03.2022.
//

import SwiftUI

struct SignUpScreen: View {
    
    @ObservedObject private var viewModel: SignUpViewModel = SignUpViewModel()
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var repeatPassword = ""
    
    @State private var showMainSeeScreen = false
    @State private var selection: String? = nil
    
    init(completion: @escaping () -> ()){
        
    }
    
    var body: some View {
        NavigationView{
        VStack {
            
            Image("LogoWithText")
                .padding(.top, 74)
            
            NavigationLink(isActive: $showMainSeeScreen) {
                MainSeeScreen().navigationBarHidden(true)
            } label: {
                EmptyView()
            }
            
            NavigationLink(destination: SignInScreen().navigationBarHidden(true), tag: "SignInScreen", selection: $selection) {
                EmptyView()
            }
            
            
            VStack (spacing: 16){
                
                TextField("", text: $firstName)
                    .modifier(PlaceholderStyle(showPlaceHolder: firstName.isEmpty, placeholder: "Имя"))
                
                TextField("", text: $lastName)
                    .modifier(PlaceholderStyle(showPlaceHolder: lastName.isEmpty, placeholder: "Фамилия"))
                
                TextField("", text: $email)
                    .modifier(PlaceholderStyle(showPlaceHolder: email.isEmpty, placeholder: "E-mail"))
                
                TextField("", text: $password)
                    .modifier(PlaceholderStyle(showPlaceHolder: password.isEmpty, placeholder: "Пароль"))
                
                TextField("", text: $repeatPassword)
                    .modifier(PlaceholderStyle(showPlaceHolder: repeatPassword.isEmpty, placeholder: "Повторите пароль"))
                
            }
            .padding(.horizontal, 16)
            .padding(.top, 64)
            
            Spacer()
            
            VStack {
                AccentButton(title: "Зарегестрироваться") {
                    if !validation() {
                        return
                    }
                    
                    if (viewModel.userRepository.postUser(userData: PostUserDataForReg(email: email, password: password, firstName: firstName, lastName: lastName)) ) {
                        showMainSeeScreen = true
                    }
                    
                }
                .padding(.trailing, 14)
                .padding(.leading, 18)
                SecondButton(title: "У меня уже есть аккаунт") {
                    selection = "SignInScreen"
                }
                .padding(.trailing, 15)
                .padding(.leading, 17)
            }
            .padding(.bottom, 78)
            .alert(item: $viewModel.alert){ item in
                Alert(title: item.title, message: item.message, dismissButton: item.dismissButton)
            }
            
        }
            .background(Color.BackgroundColor)
        
        .ignoresSafeArea()
        }
}
        

    
    func validation() -> Bool{
        let regex =  "^[a-z0-9+_.]+@[a-z0-9]+.[a-z]{1,3}$"
        
        if firstName.isEmpty {
            viewModel.alert = AlertItem(title: Text("Data is empty"), message: Text("Please, fill first name"))
            return false
        } else if lastName.isEmpty {
            viewModel.alert = AlertItem(title: Text("Data is empty"), message: Text("Please, fill first name"))
            return false
        } else if email.isEmpty {
            viewModel.alert = AlertItem(title: Text("Data is empty"), message: Text("Please, fill email"))
            return false
        } else if password.isEmpty {
            viewModel.alert = AlertItem(title: Text("Data is empty"), message: Text("Please, fill password"))
            return false
        } else if repeatPassword.isEmpty {
            viewModel.alert = AlertItem(title: Text("Data is empty"), message: Text("Please, fill repeeat paswword"))
            return false
        } else if password != repeatPassword {
            viewModel.alert = AlertItem(title: Text("Data is empty"), message: Text("Passwords don't mutch"))
            return false
        } else if ((email.range(of: regex, options: .regularExpression)) == nil) {
            viewModel.alert = AlertItem(title: Text("Data is empty"), message: Text("Email does't match"))
            return false
        }
        
        return true
        
        
    }
}
