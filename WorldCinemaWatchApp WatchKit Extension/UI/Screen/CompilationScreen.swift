//
//  CompilationScreen.swift
//  WorldCinemaWatchApp WatchKit Extension
//
//  Created by Денис Большачков on 24.03.2022.
//

import SwiftUI

struct CompilationScreen: View {
    @Environment (\.presentationMode) var presentationMode
    @StateObject var viewModel = CompilationScreenViewModel()
    
    var body: some View {
        VStack {
            Text("Cancel")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 12)
                .padding(.top, 7)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            Spacer()
            
            if viewModel.movies != nil {
                ScrollView (.horizontal){
                    HStack {
                        ForEach(viewModel.movies!, id: \.movieId) { item in
                            ImageConverter().getImageFromWeb(strUlr: "http://cinema.areas.su/up/images/" + item.poster)
                        }
                        
                    }
                }
            } else  {
                Text("Подборок нет")
            }
        }
        .background(Color.BackgroundColor)
        .ignoresSafeArea()
    }
}

struct CompilationScreen_Previews: PreviewProvider {
    static var previews: some View {
        CompilationScreen()
    }
}
