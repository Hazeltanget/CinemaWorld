//
//  MainScreen.swift
//  WorldCinemaTVApp
//
//  Created by Денис Большачков on 25.03.2022.
//

import SwiftUI

struct MainScreen: View {
    
    @StateObject var viewModel = MainScreenViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                
                HStack {
                    Text("Волан Иванов")
                    
                    Image("LogoWithText")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 40)
                .padding(.trailing, 40)
                
                VStack (alignment: .leading, spacing: 32){
                    Image("FilmNameImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 684, height: 154)
                    
                    AccentButton(title: "Смотреть") {
                        
                    }
                    .frame(width: 209, height: 56)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 80)
                .padding(.top, 67)
                
                VStack {
                    Text("В тренде")
                        .font(.system(size: 44))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if viewModel.inTrendCompilation.count > 0 {
                        ScrollView (.horizontal) {
                            HStack {
                                ForEach(viewModel.inTrendCompilation, id: \.movieId) {item in
                                    
                                    FilmCard(item: item)
                                }
                            }
                        }
                    }
                    
                }
                .padding(.top, 64)
                .padding(.leading, 80)
                VStack {
                    Text("Новое")
                        .font(.system(size: 44))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ScrollView (.horizontal) {
                        
                    }
                }
                .padding(.top, 64)
                .padding(.leading, 80)
                
                VStack {
                    Text("Для вас")
                        .font(.system(size: 44))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ScrollView (.horizontal) {
                        
                    }
                }
                .padding(.top, 64)
                .padding(.leading, 80)
            }
            .background(Image("BackgroundImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill))
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}

private struct FilmCard: View{
    var item: MovieModel
    
    @State private var buttonFocus: Bool = false
    
    var body: some View {
        Button(action: {}){
            
            VStack (spacing: 16){
                ImageConverter().getImageFromWeb(strUlr: "http://cinema.areas.su/up/images/" + item.poster)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 280)
                
                Text(item.name)
                    .bold()
                    .font(.system(size: 18))
            }
        }
        .background(Color.clear)
    }
}

