//
//  SignInScreen.swift
//  WorldCinemaTVApp
//
//  Created by Денис Большачков on 25.03.2022.
//

import SwiftUI

struct SignInScreen: View {
    
    @ObservedObject private var viewModel = SignInViewModel()
    
    @State private var selection: String? = nil
    @State private var emailText = ""
    @State private var passwordText = ""
    
    @State private var showMainScreen = false
    
    
    
    var body: some View {
        NavigationView {
            
            VStack {
                
//                NavigationLink(destination: SignUpScreen(completion: {}).navigationBarHidden(true), tag: "SignUpScreen", selection: $selection) {
//                    EmptyView()
//                }
                
                
                NavigationLink(isActive: $showMainScreen) {
                    MainScreen().navigationBarHidden(true)
                } label: {
                    EmptyView()
                }

                
                Image("LogoWithText")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.trailing, 398)
                    .padding(.leading, 396)
                    .padding(.top, 142)
                    .padding(.bottom, 88)
                
                VStack (spacing: 16){
                    TextField("", text: $emailText)
                        .textFieldStyle(PlainTextFieldStyle())
                        .modifier(PlaceholderStyle(showPlaceHolder: emailText.isEmpty, placeholder: "E-mail"))
                    SecureField("", text: $passwordText)
                        .modifier(PlaceholderStyle(showPlaceHolder: passwordText.isEmpty, placeholder: "Пароль"))
                }
                .padding(.trailing, 427)
                .padding(.leading, 439)
                .padding(.bottom, 118)
                    
                
                Spacer()
                
                VStack {
                    AccentButton(title: "Войти") {
                        if !validation() {
                            return
                        }
                        
                        if viewModel.authUser(model: PostUserDataForAuth(email: emailText, password: passwordText)) {

                            showMainScreen = true

                        }
                    }
                    .padding(.trailing, 432)
                    .padding(.leading, 434)
                }
                .padding(.bottom, 118)
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
                
            }
            content
                .foregroundColor(Color.FontColor)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.FontColor, lineWidth: 1))
                .buttonStyle(PlainButtonStyle())
        }
    }
}

struct AccentButton: View {
    
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            
            Text(title)
                .font(.system(size: 14))
                .bold()
                .foregroundColor(.white)
        }
        .frame(height: 44)
        .frame(maxWidth: .infinity)
        .background(Color.AccentColor)
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .buttonStyle(PlainButtonStyle())
    }
}


struct SecondButton: View {
    
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack{
                Text(title)
                    .font(.system(size: 14))
                    .bold()
            }
            .frame(maxWidth: .infinity)
            .overlay(RoundedRectangle(cornerRadius: 4).stroke( Color.FontColor, lineWidth: 1))
        }
        .frame(height: 44)
        .buttonStyle(PlainButtonStyle())
    }
}
