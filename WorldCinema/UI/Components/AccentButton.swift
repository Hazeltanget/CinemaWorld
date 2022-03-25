//
//  AccentButton.swift
//  WordCinameApp
//
//  Created by Денис Большачков on 10.03.2022.
//

import SwiftUI

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
    }
}
