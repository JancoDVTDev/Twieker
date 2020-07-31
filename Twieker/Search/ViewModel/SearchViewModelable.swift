//
//  SearchViewModelable.swift
//  Twieker
//
//  Created by Janco Erasmus on 2020/07/30.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

protocol SearchViewModelable: AnyObject {
  var view: SearchViewable? { get set }
  var repo: TwitterAPIRepositorable? { get set }
  func search(for query: String, with resultType: ResultType)
  func createCountSuffix(from: Int) -> String
}
