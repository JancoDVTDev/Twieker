//
//  ViewModelTests.swift
//  TwiekerTests
//
//  Created by Janco Erasmus on 2020/08/01.
//  Copyright © 2020 DVT. All rights reserved.
//

import XCTest
@testable import Twieker

class SearchViewModelTests: XCTestCase {
  
  var systemUndertest: SearchViewModel?
  var mockView: MockSearchView?
  let dispatchGroup = DispatchGroup()
  
  override func setUpWithError() throws {
    let mockRepo = MockAPIRepository()
    mockRepo.dispatchGroup = self.dispatchGroup
    
    mockView = MockSearchView()
    systemUndertest = SearchViewModel()
    systemUndertest?.repo = mockRepo
    systemUndertest?.view = mockView
  }
  
  override func tearDownWithError() throws {
    mockView = nil
    systemUndertest = nil
  }
  
  func testGivenTweetExistsWhenSearchingWithTermThenExpectTweetToBeReturned() throws {
    dispatchGroup.enter()
    systemUndertest?.search(for: TestSearchTerms.successTerm, with: .popular)
    
    dispatchGroup.wait()
    let expectedResult = TestSearchTerms.text
    let indexPath = IndexPath(row: 0, section: 0)
    let mockTweet = systemUndertest?.getTweet(indexPath: indexPath)
    XCTAssert(mockTweet?.text == expectedResult)
  }
  
  func testGivenTweetDoesNotExistWhenSearchingWithTermThenExpectViewToBeInformedNoTweetsFound() throws {
    dispatchGroup.enter()
    systemUndertest?.search(for: TestSearchTerms.successTermForEmptyTweets, with: .popular)
    
    dispatchGroup.wait()
    XCTAssertTrue(((mockView?.didTriggerNoTweetsFound) != nil))
  }
  
  func testGivenErrorInServiceCallWhenSearchingWithTermThenExpectViewToBeInformedToDisplayError() throws {
    dispatchGroup.enter()
    systemUndertest?.search(for: TestSearchTerms.failTerm, with: .popular)
    
    dispatchGroup.wait()
    XCTAssertTrue(((mockView?.didTriggerDisplayError) != nil))
  }
}
