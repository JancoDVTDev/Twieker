//
//  TwitterAPIRequestable.swift
//  Twieker
//
//  Created by Janco Erasmus on 2020/07/30.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

protocol TwitterAPIRepositorable: AnyObject {
  var session: URLSession { get }
  func fetchTweetsRequest(searchTerm: String, filterType: FilterType,
                          completion: @escaping (Result<[Tweet], Error>) -> Void)
}
