//
//  Api.swift
//  WorldCinemaWatchApp WatchKit Extension
//
//  Created by Денис Большачков on 22.03.2022.
//

import Foundation

class Api: ObservableObject {
    func authUser(model: PostUserDataForAuth, completion: @escaping  (Result<PostUserDataForAuthRecieveData, APError>) -> ()) {
        let semaphore = DispatchSemaphore (value: 0)
        
        let parameters = "{\n  \"email\": \"\(model.email)\",\n  \"password\": \"\(model.password)\"\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "http://cinema.areas.su/auth/login")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.invalidData))
                semaphore.signal()
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(PostUserDataForAuthRecieveData.self, from: data)
                completion(.success(decodedResponse))
                semaphore.signal()
            } catch {
                completion(.failure(.invalidData))
                semaphore.signal()
                print(error.localizedDescription)
            }
            
            
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
    }
    
    func getUserChats(completion: @escaping(Result<[Chat], APError>) -> ()){
        
        let semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: "http://cinema.areas.su/user/chats")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.invalidData))
                semaphore.signal()
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode([Chat].self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
        semaphore.wait()
    }
    
    func getCompilationMovies(completion: @escaping (Result<[MovieModel] ,APError>) -> ()) {
        let semaphore = DispatchSemaphore(value: 0)
        
        var request = URLRequest(url: URL(string: "http://cinema.areas.su/movies?filter=lastView")!,timeoutInterval: Double.infinity)
        request.addValue(String(UserDefaultsUtils().getToken()), forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.invalidData))
                semaphore.signal()
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodeData = try decoder.decode([MovieModel].self, from: data)
                completion(.success(decodeData))
                semaphore.signal()
            } catch {
                
                completion(.failure(.unableToComplete))
                print(error.localizedDescription)
                semaphore.signal()
            }
            
        }
        
        task.resume()
        semaphore.wait()
    }
}


enum APError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
}
