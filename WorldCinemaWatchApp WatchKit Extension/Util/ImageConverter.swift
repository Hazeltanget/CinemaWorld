//
//  ImageConverter.swift
//  WorldCinemaWatchApp WatchKit Extension
//
//  Created by Денис Большачков on 24.03.2022.
//

import Foundation
import SwiftUI
import UIKit

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
