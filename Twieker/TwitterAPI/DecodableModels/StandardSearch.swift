//
//  Tweet.swift
//  Twieker
//
//  Created by Janco Erasmus on 2020/07/29.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

struct Tweet: Decodable {
  var created_at: String
  var id_str: String
  var text: String
  var user: User
}

struct SearchResponse: Decodable {
  var statuses: [Tweet]
}

struct User: Decodable {
  var name: String
  var profile_image_url_https: URL
  var profile_background_image_url_https: URL?
  var followers_count: Int
  var friends_count: Int
  var created_at: String
  var verified: Bool
}

struct Entity: Decodable {
  var user_mentions: [UserMention]
}

struct UserMention: Decodable {
  var name: String
}
