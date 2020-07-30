//
//  Constants.swift
//  Twieker
//
//  Created by Janco Erasmus on 2020/07/30.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

struct Constants {
  
  // MARK: API Related String Constants
  static var authHeader = "Authorization"
  static var bearer = "Bearer AAAAAAAAAAAAAAAAAAAAAPZ6GQEAAAAA1TM1F52YZjxZjc" +
                      "1GQRpFx%2Br2Q54%3DYYPdvoQRRjk5sMnZv22BFT2SL6mGYEXMlucp2LJMBz4pWXtkyW"
  static var searchResourceString = "https://api.twitter.com/1.1/search/tweets.json?lang=en&count=100&q="
  
  // MARK: Tweet TableView Cell & Controller
  static var tweetCellNibName = "SearchCardTableViewCell"
  static var tweetCellReuseIdentifier = "TweetCell"
}
