//
//  Int.swift
//  Twieker
//
//  Created by Janco Erasmus on 2020/08/01.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

extension Int {
  func stringSuffix() -> String {
    let string: String
    let suffix: String
    
    if self > 999999999 {
      suffix = "B"
      string = String(String(self).dropLast(9))
    } else if self < 1000000000 && self > 999999 {
      suffix = "M"
      string = String(String(self).dropLast(6))
    } else if self < 1000000 && self > 999 {
      suffix = "k"
      string = String(String(self).dropLast(3))
    } else {
      string = String(self)
      suffix = ""
    }
    
    return "\(string)\(suffix)"
  }
}
