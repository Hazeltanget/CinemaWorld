//
//  MainScreen.swift
//  WorldCinema
//
//  Created by Денис Большачков on 16.03.2022.
//

import SwiftUI

struct MainSeeScreen: View {
    @StateObject var viewModel: MainScreenViewModel = MainScreenViewModel()
    @State private var selection: String? = nil
    @State var currentIdMovie: Int = 0
    
    let columnHeader = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    
    
    let columnsBottom = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    
    @StateObject var movieViewModel = MovieScreenViewModel()
    
    var body: some View {
        
        VStack {
            
            NavigationLink(destination: MovieScreen().navigationBarHidden(true).environmentObject(movieViewModel), tag: "MovieScreen", selection: $selection) {
                EmptyView()
            }
            
            
            ScrollView {
                VStack {
                    
                    //Header
                    ZStack {
                        (viewModel.headerImage ?? Image("Logo"))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                        Image("image 2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, alignment: .bottom)
                        
                        
                        VStack {
                            Image("mag 1")
                            
                            Spacer()
                            
                            AccentButton(title: "Смотреть", action: {
                                currentIdMovie = Int(viewModel.headerMovie!.movieId)!
                                movieViewModel.idMovie = currentIdMovie
                                selection = "MovieScreen"
                            })
                                .padding(.leading, 120)
                                .padding(.trailing, 121)
                        }
                        .frame(height: 249)
                        
                    }
                    .frame(height: 400)
                    
                    LazyVGrid(columns: columnHeader, spacing: 0){
                        ForEach(viewModel.dataForHeader) { item in
                            Button(action: {
                                viewModel.currentItem = item
                                viewModel.getItemsCompilation(filter: item.filter)
                                
                            }){
                                VStack {
                                    Spacer()
                                    
                                    Text(item.name)
                                        .font(.system(size: 17))
                                        .bold()
                                    
                                    if viewModel.currentItem.id == item.id {
                                        
                                        Rectangle()
                                            .fill(Color.AccentColor)
                                            .frame(height: 5)
                                    } else {
                                        
                                        Rectangle()
                                            .fill(Color(#colorLiteral(red: 0.2620922327, green: 0.2179895043, blue: 0.4992856979, alpha: 1)))
                                            .frame(height: 5)
                                    }
                                }
                            }
                            .padding(0)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.2620922327, green: 0.2179895043, blue: 0.4992856979, alpha: 1)))
                    .padding(.top, 6)
                    
                    
                    ScrollView (.horizontal) {
                        if !viewModel.itemsCompilation.isEmpty{
                            HStack {
                                ForEach(viewModel.itemsCompilation, id: \.movieId) { item in
                                    Button(action: {
                                        movieViewModel.idMovie = Int(item.movieId)
                                        selection = "MovieScreen"
                                    }) {
                                        ImageConverter().getImageFromWeb(strUlr: viewModel.address_for_photos + item.poster)
                                            .resizable()
                                            .frame(width: 99, height: 144)
                                    }
                                    .frame(height: 144)
                                    .frame(maxWidth: .infinity)
                                    .padding(.trailing, 16)
                                }
                            }
                            .padding(.leading, 16)
                        }
                    }
                    .frame(height: 144)
                    
                    VStack {
                        Text("Вы смотрели")
                            .font(.system(size: 24))
                            .bold()
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color.AccentColor)
                        
                        if viewModel.lastFilm != nil {
                            Button(action: {
                                movieViewModel.idMovie = Int(viewModel.lastFilm!.movieId)
                                selection = "MovieScreen"
                            }){
                                ZStack{
                                    ImageConverter().getImageFromWeb(strUlr: viewModel.address_for_photos + (viewModel.lastFilm?.poster)!)
                                        .resizable()
                                    
                                    Image("Play")
                                        .frame(width: 64, height: 64)
                                    
                                }
                                
                            }
                            .frame(height: 240)
                        }
                        
                    }
                    
                    Spacer()
                    
                }
                
            }
            LazyVGrid(columns: columnsBottom) {
                
                ForEach(viewModel.bottomBarItems) { item in
                    Button(action: {
                    }){
                        VStack{
                            item.img
                            
                            Text(item.title)
                                .font(.system(size: 10))
                                .foregroundColor(Color.BottomIconAndFontColor)
                        }
                    }
                    .padding(.top, 6)
                }
                
            }.frame(height: 50)
                .background(Color.BottomBarColor)
        }
        .background(Color.BackgroundColor)
        .ignoresSafeArea()
    }
    
}

struct MainSeeScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainSeeScreen()
    }
}

struct DataForHeaderNav: Identifiable {
    var id = UUID().uuidString
    var name: String
    var filter: String
}

struct BottomBarItem: Identifiable {
    var id = UUID()
    var img: Image
    var title: String
}
