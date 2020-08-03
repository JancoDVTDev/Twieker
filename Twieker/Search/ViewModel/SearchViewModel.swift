//
//  SearchViewModel.swift
//  Twieker
//
//  Created by Janco Erasmus on 2020/07/30.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
import UIKit

class SearchViewModel {
  
  weak var view: SearchViewable?
  lazy var repo: TwitterAPIRepositorable = TwitterAPIRepository()
  private (set) var tweets = [Tweet]()
  
  func search(for searchTerm: String, with filterType: FilterType) {
    let trimmedSearchTerm = searchTerm.replacingOccurrences(of: " ", with: "%20")
        
    repo.fetchTweetsRequest(searchTerm: trimmedSearchTerm, filterType: filterType, completion: { (result) in
      
      do {
        let tweets = try result.get()
        if tweets.isEmpty {
          self.view?.noTweetsFound()
        } else {
          var mutableTweets = tweets
          for index in 0..<mutableTweets.count {
            let customDate = self.createTimePostedString(with: tweets[index].createdAt)
            mutableTweets[index].createdAt = customDate
          }
          self.tweets = mutableTweets
          self.view?.tweetsFound()
        }
      } catch {
        self.view?.displayError(with: error.localizedDescription)
      }
    })
  }
  
  func getTweet(indexPath: IndexPath) -> Tweet {
    let index = indexPath.row
    return tweets[index]
  }
      
  private func createTimePostedString(with stringDate: String) -> String {
    let calendar = Calendar.current
    guard let date = convertStringToDate(with: stringDate) else { return "N/A" }
    let second = calendar.component(.second, from: date)
    let minute = calendar.component(.minute, from: date)
    let hour = calendar.component(.hour, from: date)
    
    let customDate: String
    
    if second < 60 && minute == 0 && hour == 0 {
      customDate = "\(second) seconds ago"
    } else if minute < 60 && hour == 0{
      customDate = "\(minute) minutes ago"
    } else if hour < 12 && calendar.isDateInToday(date) {
      customDate = "\(hour) hours ago"
    } else {
      if calendar.isDateInToday(date) {
        customDate = "Today"
      } else if calendar.isDateInYesterday(date) {
        customDate = "Yesterday"
      } else {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        customDate = formatter.string(from: date)
      }
    }
    return customDate
  }
  
  private func convertStringToDate(with string: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "E MMM d HH:mm:ss z yyyy"
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.locale = Locale.current
    return dateFormatter.date(from: string)
  }
}

enum FilterType {
  case recent
  case popular
  
  var value: String {
    switch self {
    case .recent:
      return "recent"
    case .popular:
      return "popular"
    }
  }
}
