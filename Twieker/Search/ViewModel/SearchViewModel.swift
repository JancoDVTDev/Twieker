//
//  SearchViewModel.swift
//  Twieker
//
//  Created by Janco Erasmus on 2020/07/30.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
import UIKit

class SearchViewModel: SearchViewModelable {
  
  weak var view: SearchViewable?
  var repo: TwitterAPIRepositorable?
  
  func search(for query: String, with resultType: ResultType) {
    let urlReadyQuery = query.replacingOccurrences(of: " ", with: "%20")
    
    repo?.fetchTweetsRequest(query: urlReadyQuery, resultType: resultType, completion: { (tweets, error) in
      if let error = error {
        self.view?.errorFound(with: error)
      } else {
        guard let tweets = tweets else { return }
        var mutableTweets = tweets
        for index in 0..<mutableTweets.count {
          let customDate = self.createCustomDate(with: tweets[index].created_at)
          mutableTweets[index].created_at = customDate
        }
        self.view?.updateTweets(with: mutableTweets)
      }
    })
  }
  
  func createCountSuffix(from count: Int) -> String {
    var suffix = String()
    var stringCount = String(count)
    
    if count > 999999 {
      suffix = "M"
      stringCount = String(stringCount.dropLast(5))
    } else if count < 1000000 && count > 999 {
      suffix = "k"
      stringCount = String(stringCount.dropLast(3))
    }
    
    return "\(stringCount)\(suffix)"
  }
  
  private func createCustomDate(with stringDate: String) -> String {
    let calendar = Calendar.current
    guard let date = convertStringToDate(with: stringDate) else { return "N/A" }
    let second = calendar.component(.second, from: date)
    let minute = calendar.component(.minute, from: date)
    let hour = calendar.component(.hour, from: date)
    
    var customDate = String()
    
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
