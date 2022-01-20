//
//  NetworkingManager.swift
//  Public API App v2
//
//  Created by Дмитрий Чепанов on 19.01.2022.
//


import Foundation

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
    
}


//    func fetchMemes(url: String, complition: @escaping(_ mem: MemsModel) -> Void) {
//        guard let url = URL(string: url) else { return }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, let _ = response else {
////                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//
//            do {
//                let memsDescription = try JSONDecoder().decode(MemsModel.self, from: data)
//                DispatchQueue.main.async {
//                    complition(memsDescription)
////                    print(memsDescription)
//                }
////                self.successAlert()
////                print("MemesDescription: \(memsDescription)")
//            } catch {
////                self.failedAlert()
////                print(error.localizedDescription)
//            }
//        }.resume()
//    }

//    func fetchMemes(url: String, complition: @escaping(Result<MemsModel, NetworkingError>) -> Void) {
//        guard let url = URL(string: url) else { return }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, let _ = response else {
////                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//
//            do {
//                let memsDescription = try JSONDecoder().decode(MemsModel.self, from: data)
//                DispatchQueue.main.async {
//                    complition(memsDescription)
////                    print(memsDescription)
//                }
////                self.successAlert()
////                print("MemesDescription: \(memsDescription)")
//            } catch {
////                self.failedAlert()
////                print(error.localizedDescription)
//            }
//        }.resume()
//    }
//}
