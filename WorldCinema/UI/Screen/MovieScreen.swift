//
//  MovieScreen.swift
//  WorldCinema
//
//  Created by Денис Большачков on 16.03.2022.
//

import SwiftUI
import AVKit
import WrappingHStack

struct MovieScreen: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var movieViewModel: MovieScreenViewModel
    
    @State  private var items: [TagModel] = [TagModel(idTags: "13", tagName: "США"),TagModel(idTags: "15", tagName: "США"),TagModel(idTags: "14", tagName: "asdfasdf"),TagModel(idTags: "16", tagName: "asdffsad"),TagModel(idTags: "17", tagName: "asdfdsaf"),TagModel(idTags: "17", tagName: "asdfdsaf")]
    
    var body: some View {
        ScrollView {
            VStack {
                
                ZStack {
                    (ImageConverter().getImageFromWeb(strUlr: MovieScreenViewModel.address_for_images + movieViewModel.currentMovie!.poster))
                        .resizable()
                        .frame(height: 400)
                    
                    VStack {
                        HStack {
                            
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }){
                                Image("ButtonBack")
                            }
                            
                            Spacer()
                            
                            Text(movieViewModel.currentMovie!.name)
                                .font(.system(size: 17))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            HStack (spacing: 16){
                                switch movieViewModel.currentMovie!.age {
                                case "18":
                                    Image("18+")
                                    
                                case "16":
                                    Image("16+")
                                    
                                case "12":
                                    Image("12+")
                                    
                                case "6":
                                    Image("6+")
                                    
                                case "0":
                                    Image("0+")
                                default:
                                    Image("18+")
                                }
                                
                                Image("uil_comments")
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 55)
                        .padding(.leading, 8)
                        .padding(.trailing, 16)
                        
                        Spacer()
                        
                        WrappingHStack {
                            ForEach(movieViewModel.currentMovie!.tags, id: \.idTags) { item in
                                TagItem(tag: item)
                                    .padding(.bottom, 7)
                                    .padding(.trailing, 9)
                                    .clipShape(RoundedRectangle(cornerRadius: 4))
                            }
                        }
                        .frame(height: 100)
                        .frame(minWidth: UIScreen.main.bounds.width - 70)
                        .padding(.trailing, 64)
                        
                    }
                }
                
                VStack {
                    Text("Смотреть")
                        .bold()
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .padding(.top, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                    
                    
                    if !movieViewModel.episodes!.isEmpty {
                        VideoPlayer(player: AVPlayer(url: URL(string: MovieScreenViewModel.address_for_video + movieViewModel.episodes![0].preview)!))
                            .frame(height: 210)
                    
                    }
                    
                }
                .padding(.top, 16)
                
                VStack {
                    Text("Описание")
                        .bold()
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .padding(.top, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                    
                    Text(movieViewModel.currentMovie!.description)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(.top, 8)
                        .padding(.horizontal, 16)
                    
                }
                .padding(.top, 16)
                
                VStack {
                    Text("Кадры")
                        .bold()
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .padding(.top, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                    
                    ScrollView (.horizontal){
                        HStack (spacing: 16){
                            
                            if !((movieViewModel.currentMovie?.images.isEmpty)!){
                                ForEach(movieViewModel.currentMovie!.images, id: \.self) { item in
                                    ImageConverter().getImageFromWeb(strUlr: MovieScreenViewModel.address_for_images + item)
                                        .resizable()
                                        .frame(width: 128, height: 72)
                                }
                            }
                        }
                    }
                    
                    
                }
                .padding(.top, 16)
                
                VStack {
                    Text("Эпизоды")
                        .bold()
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .padding(.top, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                    
                    
                    VStack (spacing: 16){
                        ForEach(movieViewModel.episodes!, id: \.episodeId) { item in
                            Episode(model: item)
                        }
                    }
                    
                    
                }
                .padding(.top, 16)
                
            }
        }
        .background(Color.BackgroundColor)
        .ignoresSafeArea()
    }
}

//struct MovieScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieScreen(movieId: 2)
//    }
//}

private struct TagItem: View {
    var tag: TagModel
    
    var body: some View {
        ZStack {
            Text(tag.tagName)
                .font(.system(size: 14))
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical,1)
        }
        .background(Color.AccentColor)
    }
}

private struct Episode: View {
    
    var model: EpisodeMovie
    
    var  body: some View {
        HStack {
            if model.images.count > 0 {
            Image(MovieScreenViewModel.address_for_images + model.images[0])
                .resizable()
                .frame(width: 128, height: 72)
            } else {
                Image("image 1")
                    .resizable()
                    .frame(width: 128, height: 72)
            }
            
            Spacer()
            
            VStack  (alignment: .leading){
                Text(model.name)
                    .bold()
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                
                Text(model.description)
                    .font(.system(size: 12))
                    .foregroundColor(Color.FontColor)
                    .lineLimit(2)
                    .padding(.top, 12)
                    .frame(width: 199, height: 28)
                
                Text(model.year)
                    .font(.system(size: 12))
                    .foregroundColor(Color.FontColor)
                    .padding(.top, 6)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 16)
            
            
        }
        .frame(height: 72)
        .padding(.horizontal, 16)
    }
}
