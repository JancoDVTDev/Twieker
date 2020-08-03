//
//  MockAPIRepository.swift
//  TwiekerTests
//
//  Created by Janco Erasmus on 2020/08/01.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
@testable import Twieker

class MockAPIRepository: TwitterAPIRepositorable {
  var session: URLSession = MockURLSession()
  
  var dispatchGroup = DispatchGroup()
  
  func fetchTweetsRequest(searchTerm: String, filterType: FilterType, completion: @escaping (Result<[Tweet], Error>) -> Void) {
    
    let mockUser = User(name: "Peter", profileImageUrl: URL(string: "https")!, profileBackgroundImageUrl: nil, followersCount: 534, friendsCount: 2435654, createdAt: "Sat Aug 01 19:24:45 +0000 2020", verified: true)
    let mockTweet = Tweet(createdAt: "Sat Aug 01 19:24:45 +0000 2020", id: "13265825", text: "We've had some success with this tweet", user: mockUser)
    let mockError = NSError(domain: "Mock Error For Testing Purposes", code: 0, userInfo: nil)
    
    if searchTerm == TestSearchTerms.successTerm {
      completion(.success([mockTweet]))
      dispatchGroup.leave()
    }else if searchTerm == TestSearchTerms.successTermForEmptyTweets {
      completion(.success([]))
      dispatchGroup.leave()
    }else {
      completion(.failure(mockError))
      dispatchGroup.leave()
    }
  }
}
