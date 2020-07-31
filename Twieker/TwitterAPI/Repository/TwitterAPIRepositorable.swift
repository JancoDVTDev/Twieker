//
//  TwitterAPIRequestable.swift
//  Twieker
//
//  Created by Janco Erasmus on 2020/07/30.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

protocol TwitterAPIRepositorable: AnyObject {
  var session: URLSession { get set }
  func fetchTweetsRequest(query: String, resultType: ResultType,
                          completion: @escaping (_ tweets: [Tweet]?, _ error: String?) -> Void)
}
