//
//  MockSearchView.swift
//  TwiekerTests
//
//  Created by Janco Erasmus on 2020/08/03.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
@testable import Twieker

class MockSearchView {
  var didTriggerDisplayError = false
  var didTriggerNoTweetsFound = false
}
extension MockSearchView: SearchViewable {
  func tweetsFound() {
    // Tested by checking that text in the model is returned.
  }
  
  func displayError(with message: String) {
    didTriggerDisplayError = true
  }
  
  func noTweetsFound() {
    didTriggerNoTweetsFound = true
  }
}
