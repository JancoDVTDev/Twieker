//
//  TwitterAPIRequest.swift
//  Twieker
//
//  Created by Janco Erasmus on 2020/07/29.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

class TwitterAPIRepository: TwitterAPIRepositorable {
  
  let session: URLSession = URLSession.shared
  
  func fetchTweetsRequest(searchTerm: String, filterType: FilterType,
                          completion: @escaping (Result<[Tweet], Error>) -> Void) {
    let resourceString = "\(Constants.searchResourceString)&q=\(searchTerm)&result_type=\(filterType.value)"
    guard let resourceURL = URL(string: resourceString) else { return }
    
    var request = URLRequest(url: resourceURL)
    request.httpMethod = "GET"
    request.addValue(Constants.bearer, forHTTPHeaderField: Constants.authHeader)
    
    let dataTask = session.dataTask(with: request) { data, response, error in
      if let error = error {
        completion(.failure(error))
      } else {
        if let jsonData = data {
          do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(SearchResponse.self, from: jsonData)
            let tweets = response.statuses
            completion(.success(tweets))
          } catch {
            completion(.failure(error))
          }
        }
      }
    }
    dataTask.resume()
  }
}
