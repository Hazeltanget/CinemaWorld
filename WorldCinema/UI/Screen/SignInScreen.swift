//
//  SignInScreen.swift
//  WorldCinema
//
//  Created by Денис Большачков on 16.03.2022.
//

import SwiftUI

struct SignInScreen: View {
    
    @ObservedObject private var viewModel = SignInViewModel()
    
    @State private var selection: String? = nil
    @State private var emailText = ""
    @State private var passwordText = ""
    
    @State private var showMainSeeScreen = false
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                NavigationLink(destination: SignUpScreen(completion: {}).navigationBarHidden(true), tag: "SignUpScreen", selection: $selection) {
                    EmptyView()
                }
                
                
                NavigationLink(isActive: $showMainSeeScreen) {
                    MainSeeScreen().navigationBarHidden(true)
                } label: {
                    EmptyView()
                }

                
                Image("LogoWithText")
                    .padding(.top, 88)
                
                VStack (spacing: 16){
                    TextField("", text: $emailText)
                        .modifier(PlaceholderStyle(showPlaceHolder: emailText.isEmpty, placeholder: "E-mail"))
                        .padding(.trailing, 15)
                        .padding(.leading, 17)
                    SecureField("", text: $passwordText)
                        .modifier(PlaceholderStyle(showPlaceHolder: passwordText.isEmpty, placeholder: "Пароль"))
                        .padding(.trailing, 15)
                        .padding(.leading, 17)
                }
                .padding(.top, 104)
                
                Spacer()
                
                VStack {
                    AccentButton(title: "Войти") {
                        if !validation() {
                            return
                        }
                        
                        if viewModel.authUser(model: PostUserDataForAuth(email: emailText, password: passwordText)) {
                            
                            showMainSeeScreen = true
                            
                        }
                    }
                    .padding(.trailing, 14)
                    .padding(.leading, 18)
                    SecondButton(title: "Регистрация") {
                        
                        selection = "SignUpScreen"
                    }
                    .padding(.trailing, 15)
                    .padding(.leading, 17)
                }
                .padding(.bottom, 78)
                .alert(item: $viewModel.alert) { item in
                    Alert(title: item.title, message: item.message, dismissButton: item.dismissButton)
                }
                
                
            }
            .background(Color.BackgroundColor)
            .ignoresSafeArea()
            
            

        }
    }
    
    func validation() -> Bool {
        
        let regex =  "^[a-z0-9+_.]+@[a-z0-9]+.[a-z]{1,3}$"
        
        if emailText.isEmpty {
            viewModel.alert = AlertItem(title: Text("Data is empty"), message: Text("Please, fill email"))
            return false
        } else if passwordText.isEmpty{
            viewModel.alert = AlertItem(title: Text("Data is empty"), message: Text("Please, fill password"))
            return false
        } else if ((emailText.range(of: regex, options: .regularExpression)) == nil) {
            viewModel.alert = AlertItem(title: Text("Data is empty"), message: Text("Email does't match"))
            return false
        }
        
        return true
    }
}

struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
    }
}

public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                ZStack {
                    Text(placeholder)
                        .foregroundColor(Color.FontColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                }
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.FontColor, lineWidth: 1)
                )
                
            }
            content
                .foregroundColor(Color.FontColor)
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .padding(.leading, 16)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.FontColor, lineWidth: 1))
        }
    }
}
