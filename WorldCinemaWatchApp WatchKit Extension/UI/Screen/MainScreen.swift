//
//  MainScreen.swift
//  WorldCinemaWatchApp WatchKit Extension
//
//  Created by Денис Большачков on 24.03.2022.
//

import SwiftUI

struct MainScreen: View {
    
    @Environment (\.presentationMode) var presentationMode
    
    var itemsOfLinks = [ItemOfCircleLinks(title: "Обсуждения", img: Image("Vector")),
                        ItemOfCircleLinks(title: "Подборки", img: Image("Vector1")),
                        ItemOfCircleLinks(title: "Избранное", img: Image("Vector2")) ]
    
    @State private var selection: String? = nil
    
    var body: some View {
        VStack {
            
            NavigationLink(destination: InDevelopingScreen().navigationBarHidden(true), tag: "InDevelopingScreen", selection: $selection) {
                EmptyView()
            }
            .buttonStyle(PlainButtonStyle())
            
            NavigationLink(destination: ChatListScreen().navigationBarHidden(true), tag: "ChatListScreen", selection: $selection) {
                EmptyView()
            }
            .buttonStyle(PlainButtonStyle())
            
            NavigationLink(destination: CompilationScreen().navigationBarHidden(true), tag: "CompilationScreen", selection: $selection) {
                EmptyView()
            }
            .buttonStyle(PlainButtonStyle())
            
            Text("Cancel")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 12)
                .padding(.top, 7)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            
            
            
            LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())], spacing: 16) {
                ForEach(itemsOfLinks, id: \.id) { item in
                    VStack {
                        Button(action: {
                            switch item.title {
                            case "Обсуждения":
                                selection = "ChatListScreen"
                                break
                            case "Подборки":
                                selection = "CompilationScreen"
                                break
                            default:
                                break
                            }
                        }){
                            item.img
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 67, height: 67)
                        .background(Color.AccentColor)
                        .clipShape(Circle())
                        
                        Text(item.title)
                            .font(.system(size: 14))
                    }
                    
                }
            }
            .padding(.top, 4)
    
            
            
            Spacer()
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity)
        .background(Color.BackgroundColor)
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}

struct ItemOfCircleLinks: Identifiable {
    var id = UUID()
    var title: String
    var img: Image
}
