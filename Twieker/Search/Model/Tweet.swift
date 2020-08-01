//
//  Tweet.swift
//  Twieker
//
//  Created by Janco Erasmus on 2020/07/29.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation


struct Tweet: Decodable {
  var createdAt: String
  var id: String
  var text: String
  var user: User
  
  enum CodingKeys: String, CodingKey {
    case id = "id_str"
    case createdAt = "created_at"
    case text
    case user
  }
}
