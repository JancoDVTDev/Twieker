//
//  TwitterAPIRequest.swift
//  Twieker
//
//  Created by Janco Erasmus on 2020/07/29.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

class TwitterAPIRepository: TwitterAPIRepositorable {
  
  var session: URLSession = URLSession.shared
  
  func fetchTweetsRequest(query: String, resultType: ResultType,
                          completion: @escaping (_ tweets: [Tweet]?, _ error: String?) -> Void) {
    let resourceString = "\(Constants.searchResourceString)&q=\(query)&result_type=\(resultType.value)"
    guard let resourceURL = URL(string: resourceString) else { return }
    
    var request = URLRequest(url: resourceURL)
    request.httpMethod = "GET"
    request.addValue(Constants.bearer, forHTTPHeaderField: Constants.authHeader)
    
    let dataTask = session.dataTask(with: request) { data, response, error in
      if let error = error {
        completion(nil, error.localizedDescription)
      } else {
        if let jsonData = data {
          do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(SearchResponse.self, from: jsonData)
            let tweets = response.statuses
            completion(tweets, nil)
          } catch {
            completion(nil, "Cannot process data")
          }
        }
      }
    }
    dataTask.resume()
  }
}
