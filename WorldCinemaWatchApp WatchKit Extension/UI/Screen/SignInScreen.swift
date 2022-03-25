//
//  SignInScreen.swift
//  WorldCinemaWatchApp WatchKit Extension
//
//  Created by Денис Большачков on 22.03.2022.
//

import SwiftUI

struct SignInScreen: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @StateObject private var viewModel = SignInViewModel()
    
    @State private var selection: String? = nil
    
    var body: some View {
        NavigationView{
        VStack {
            
            
            NavigationLink(destination: MainScreen().navigationBarHidden(true), tag: "MainScreen", selection: $selection) {
                EmptyView()
            }
            .buttonStyle(PlainButtonStyle())
        
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 64)
            
            
            VStack (spacing: 7){
                TextField( "", text: $email)
                    .modifier(PlaceholderStyle(showPlaceHolder: email.isEmpty, placeholder: "Email"))
                    .multilineTextAlignment(.center)
                TextField( "", text: $password)
                    .multilineTextAlignment(.center)
                    .modifier(PlaceholderStyle(showPlaceHolder: password.isEmpty, placeholder: "Пароль"))
                
                Button(action: {
                    auth()
                }){
                    Text("Войти")
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .padding(.horizontal, 2)
                .background(Color.AccentColor)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .buttonStyle(PlainButtonStyle())
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .background(Color.BackgroundColor)
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .alert(item: $viewModel.alert) { item in
            Alert(title: item.title, message: item.message, dismissButton: item.dismissButton)
        }
    }
    
    
    func auth() -> Void{
        
        if (!validation()) {
            return
        }
        
        if viewModel.authUser(model: PostUserDataForAuth(email: email, password: password)) {
            selection = "MainScreen"
        }
    }
    
    func validation() -> Bool {
        
        let regex =  "^[a-z0-9+_.]+@[a-z0-9]+.[a-z]{1,3}$"
        
        if email.isEmpty {
            viewModel.alert = AlertItem(title: Text("Data error"), message: Text("Email is empty"))
            return false
        } else if password.isEmpty {
            viewModel.alert = AlertItem(title: Text("Data error"), message: Text("Password is empty"))
            return false
        } else if email.range(of: regex, options: .regularExpression) == nil {
            viewModel.alert = AlertContext.invalidEmail
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
        ZStack(alignment: .center) {
            if showPlaceHolder {
                ZStack {
                    Text(placeholder)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    
                }
            }
            content
                .foregroundColor(Color.white)
        }
    }
}
