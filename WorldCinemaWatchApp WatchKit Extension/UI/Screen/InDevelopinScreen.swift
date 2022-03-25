//
//  InDevelopinScreen.swift
//  WorldCinemaWatchApp WatchKit Extension
//
//  Created by Денис Большачков on 24.03.2022.
//

import SwiftUI

struct InDevelopingScreen: View {
    
    @Environment (\.presentationMode) var presentationMode
    
    
    var body: some View {
        ZStack {
            
        
        VStack {
            Text("Cancel")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 12)
                .padding(.top, 7)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            
            Spacer()
        }
            
            Text("В разработке")
        }
        .frame(maxHeight: .infinity)
        .ignoresSafeArea()
        
    }
}

struct InDevelopingScreen_Previews: PreviewProvider {
    static var previews: some View {
        InDevelopingScreen()
    }
}
