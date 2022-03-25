//
//  SecondButton.swift
//  WordCinameApp
//
//  Created by Денис Большачков on 10.03.2022.
//

import SwiftUI

struct SecondButton: View {
    
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            
            Text(title)
                .font(.system(size: 14))
                .bold()
            
            
        }
        .frame(height: 44)
        .frame(maxWidth: .infinity)
        .overlay(RoundedRectangle(cornerRadius: 4).stroke( Color.FontColor, lineWidth: 1))
    }
}

