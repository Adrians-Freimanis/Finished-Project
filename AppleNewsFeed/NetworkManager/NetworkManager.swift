//
//  NetworkManager.swift
//  RestCountriesApp
//
//  Created by adrians.freimanis on 19/05/2023.
//

import Foundation


class NetworkManager {
    
    
    
    static let api = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=f9eafead63904cf0800dc486449dc939"
    
    static func fetchData(url: String, completion: @escaping (NewsItems) -> () ) {

        guard let url = URL(string: url) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true

        URLSession(configuration: config).dataTask(with: request) { (data, response, err ) in

            guard err == nil else {
                print("err:::::", err!)
                return
            }

            //print("response:", response as Any)

            guard let data = data else { return }


            do {
                let jsonData = try JSONDecoder().decode(NewsItems.self, from: data)
                completion(jsonData)
            }catch{
                print("err:::::", error)
            }

        }.resume()

    }
    
    
}
