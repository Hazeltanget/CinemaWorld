//
//  UserRepository.swift
//  WorldCinemaTVApp
//
//  Created by Денис Большачков on 25.03.2022.
//

import Foundation

class UserRepository {
    static var API_ADDRESS: String = "http://cinema.areas.su/"
    
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
            } catch {
                completion(.failure(.invalidData))
            }
            
            
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
    }
    
    func postUser(userData: PostUserDataForReg) -> Bool{
        let semaphore = DispatchSemaphore (value: 0)
        
        var toRet = false
        
        let parameters = "{\n  \"email\": \"\(userData.email)\",\n  \"password\": \"\(userData.password)\",\n  \"firstName\": \"\(userData.firstName)\",\n  \"lastName\": \"\(userData.lastName)\"\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "http://cinema.areas.su/auth/register")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard data != nil else {
                semaphore.signal()
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 201 {
                toRet = true
             }
            
            semaphore.signal()
        }
        
        
        task.resume()
        semaphore.wait()
        
        return toRet
    }
}
