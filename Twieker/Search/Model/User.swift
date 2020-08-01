//
//  User.swift
//  Twieker
//
//  Created by Janco Erasmus on 2020/08/01.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

struct User: Decodable {
  var name: String
  var profileImageUrl: URL
  var profileBackgroundImageUrl: URL?
  var followersCount: Int
  var friendsCount: Int
  var createdAt: String
  var verified: Bool
  
  private enum CodingKeys: String, CodingKey {
    case name
    case profileImageUrl = "profile_image_url_https"
    case profileBackgroundImageUrl = "profile_background_image_url_https"
    case followersCount = "followers_count"
    case friendsCount = "friends_count"
    case createdAt = "created_at"
    case verified
  }
}
