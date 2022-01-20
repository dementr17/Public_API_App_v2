//
//  NetworkingManager.swift
//  Public API App v2
//
//  Created by Дмитрий Чепанов on 19.01.2022.
//


import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkingManager {
    static var shared = NetworkingManager()
    
    private init() {}
    
    func fetch<T: Decodable>(dataType: T.Type, from url: String, convertFromSnakeCase: Bool = true, completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let decoder = JSONDecoder()
                if convertFromSnakeCase {
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                }
                
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    

    func fetchImage(from url: String?) -> Data? {
        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil }
        return try? Data(contentsOf: imageURL)
    }
    
    func fetchDataWithAlomafire(_ url: String, completion: @escaping(Result<[Memes], NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                guard let statusCode = dataResponse.response?.statusCode else { return }
//                print("Status Code: ", statusCode)
                if(200..<300).contains(statusCode){
                    guard let value = dataResponse.value else {return}
//                    print("value: ", value)
                } else {
                    guard let error = dataResponse.error else {return}
                    print("Error: ", error)
                }

                switch dataResponse.result {
                case .success(let value):
                    print(value)
                    guard let memesData = value as? [[String: Any]] else { return }
                    print(memesData)
                    
                    let memes = Memes.getMemes(from: value)
                    completion(.success(memes))
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
    }
}

