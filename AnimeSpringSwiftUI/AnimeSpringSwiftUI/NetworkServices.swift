//
//  NetworkServices.swift
//  AnimeSpringSwiftUI
//
//  Created by Natália Brocca on 01/05/20.
//  Copyright © 2020 Natália Brocca. All rights reserved.
//

import Foundation
class NetworkServices {
    let baseURL = "https://ghibliapi.herokuapp.com"
    
    func getAllMovies (handler: @escaping (MovieAPI?, Error?) -> Void) {
        guard let url = URL(string: "\(baseURL)/films") else {
            print("Error: cannot create URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                handler(nil, error)
            } else if let data = data {
                handler(try? JSONDecoder().decode(MovieAPI.self, from: data), nil)
            } else {
                handler(nil, nil)
            }
        }
        task.resume()
    }
}
