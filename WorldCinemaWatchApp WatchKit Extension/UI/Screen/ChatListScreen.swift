//
//  ChatListScreen.swift
//  WorldCinemaWatchApp WatchKit Extension
//
//  Created by Денис Большачков on 24.03.2022.
//

import SwiftUI

struct ChatListScreen: View {
    
    @Environment (\.presentationMode) var presentationMode
    
    @StateObject var viewModel = ChatScreenViewModel()
    
    
    var body: some View {
        VStack {
            Text("Cancel")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 12)
                .padding(.top, 7)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            
            Text("Обсуждения")
                .foregroundColor(Color.AccentColor)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 12)
                .padding(.top, 10)
            
            if viewModel.chats != nil {
                ForEach(viewModel.chats!, id: \.chatId) { item in
                    ChatItem(chat: item, action: {})
                }
            }
            
            Spacer()
        }
        .ignoresSafeArea()
        .background(Color.BackgroundColor)
    
    }
}

struct ChatListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatListScreen()
    }
}


struct ChatItem: View {
    var chat: Chat
    var action: () -> ()
    
    var body: some View {
        Button(action: {}){
            HStack (spacing: 92) {
                Text(chat.name)
                    .lineLimit(1)
                
                Text(String(Int.random(in: 0...100)))
                    .foregroundColor(Color.AccentColor)
                
            }
            .frame(maxWidth: .infinity)
            
        }
    }
}
