//
//  ImageConverter.swift
//  WordCinameApp
//
//  Created by Денис Большачков on 14.03.2022.
//

import SwiftUI
import Foundation

class ImageConverter {
    
    func getImageFromWeb(strUlr: String) -> Image {
        let url = URL(string: strUlr)!
        let img: Image
        let uiImage: UIImage
        
        do {
            let data = try! Data(contentsOf: url)
            uiImage = UIImage(data: data)!
            
            img = Image(uiImage: uiImage)
        } catch {
            
        }
        
        return img
    }
}
