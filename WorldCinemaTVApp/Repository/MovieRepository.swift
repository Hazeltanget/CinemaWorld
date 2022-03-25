//
//  MovieRepository.swift
//  WorldCinema
//
//  Created by Денис Большачков on 16.03.2022.
//

import Foundation

class MovieRepository {
    
    func getCoverMovie() -> MovieCoverModel? {
        let semaphore = DispatchSemaphore (value: 0)
        var modelToRet: MovieCoverModel? = nil
        
        var request = URLRequest(url: URL(string: "http://cinema.areas.su/movies/cover")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            
            modelToRet = try! JSONDecoder().decode(MovieCoverModel.self, from: data)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return modelToRet
    }
    
    func getCompilationMovies(filter: String, completion: @escaping (Result<[MovieModel] ,APError>) -> ()) {
        var request = URLRequest(url: URL(string: "http://cinema.areas.su/movies?filter=\(filter)")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodeData = try decoder.decode([MovieModel].self, from: data)
                completion(.success(decodeData))
            } catch {
                
                completion(.failure(.unableToComplete))
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
    }
    
    
    func getUserMovies(filter: String, completion: @escaping (Result<[UserMovieModel] ,APError>) -> ()) {
        var request = URLRequest(url: URL(string: "http://cinema.areas.su/usermovies?filter=lastView")!,timeoutInterval: Double.infinity)
        request.addValue(String(UserDefaultsUtils().getToken()), forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodeData = try decoder.decode([UserMovieModel].self, from: data)
                completion(.success(decodeData))
            } catch {
                completion(.failure(.unableToComplete))
                print(String(describing: error))
            }
            
        }
        
        task.resume()
    }
    
    func getMovie(idMovie: Int) -> MovieModel {
        
        var request = URLRequest(url: URL(string: "http://cinema.areas.su/movies/\(idMovie)")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let semaphore = DispatchSemaphore(value: 0)
        
        var modelToRet: MovieModel? = nil
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                semaphore.signal()
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodeData = try decoder.decode(MovieModel.self, from: data)
                modelToRet = decodeData
                semaphore.signal()
                
            } catch {
                print(error)
                semaphore.signal()
            }
        }
        task.resume()
        semaphore.wait()
        
        return modelToRet!
    }
    
    func getEpisodesMovie(movieId: Int) -> [EpisodeMovie] {
        let semaphore = DispatchSemaphore (value: 0)
    
        var modelToRet: [EpisodeMovie] = [EpisodeMovie]()
        
        var request = URLRequest(url: URL(string: "http://cinema.areas.su/movies/\(movieId)/episodes")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodeData = try decoder.decode([EpisodeMovie].self, from: data)
                modelToRet = decodeData
                semaphore.signal()
                
            } catch {
                print(error.localizedDescription)
                semaphore.signal()
            }
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return modelToRet
    }
}
