//
//  NetworkManager.swift
//  PruebaTecninca
//
//  Created by Rafael Ortega on 10/05/22.
//

import Foundation
import UIKit

class NetworkManager {
    
    struct Constants {
        static let shared = Constants()
        
        let URL: String = "https://api.unsplash.com/search/photos"
    }
    
    static var shared = NetworkManager()
    private var images = NSCache<NSString, NSData>()
    
    func fetchData(completion:@escaping ((NSError?, [DataResult]?)->Void)) {
        guard var urlComponents = URLComponents(string: Constants.shared.URL) else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "query", value: "anime"),
            URLQueryItem(name: "per_page", value: "10")
        ]
        
        guard let url = urlComponents.url else { return }
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(apiKey)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                let dataResponse = try JSONDecoder().decode(DataResponse.self, from: data)
                completion(nil, dataResponse.results)
            } catch let error as NSError {
                completion(error, nil)
            }
            
        }
        task.resume()
    }
    
    func getImage(fromStringURL url: URL) async throws -> UIImage? {
        if let imageData = self.images.object(forKey: url.absoluteString as NSString) {
            return UIImage(data: imageData as Data)
        }
        do {
            let (localURL, _) = try await URLSession.shared.download(from: url)
            let data = try Data(contentsOf: localURL)
            self.images.setObject(data as NSData, forKey: url.absoluteString as NSString)
            return UIImage(data: data)
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
        
    }
    
    
}
