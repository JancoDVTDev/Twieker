//
//  SearchViewable.swift
//  Twieker
//
//  Created by Janco Erasmus on 2020/07/30.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

protocol SearchViewable: AnyObject {
  func updateTweets(with results: [Tweet])
  func errorFound(with message: String)
}
