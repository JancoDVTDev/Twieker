
//
//  MockURLSession.swift
//  TwiekerTests
//
//  Created by Janco Erasmus on 2020/08/01.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

class MockURLSession: URLSession {
  override func dataTask(with url: URL) -> URLSessionDataTask {
    return URLSessionDataTask()
  }
}
