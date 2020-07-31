//
//  SearchViewController.swift
//  Twieker
//
//  Created by Janco Erasmus on 2020/07/29.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
  @IBOutlet var tweetSearchBar: UISearchBar!
  @IBOutlet var tweetsResultTableView: UITableView!
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  @IBOutlet var noTweetsFoundStackView: UIStackView!
  
  var viewModel: SearchViewModelable!
  var tweets = [Tweet]()
  
  var restultType: ResultType = .recent
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let onViewTap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    self.view.addGestureRecognizer(onViewTap)
    
    activityIndicator.isHidden = true
    
    viewModel = SearchViewModel()
    
    viewModel.repo = TwitterAPIRepository()
    viewModel.view = self
            
    tweetSearchBar.delegate = self
    tweetsResultTableView.delegate = self
    tweetsResultTableView.dataSource = self
    createTableViewHeader()
    configureTweetCellNib()
  }
      
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchTopics()
  }
  
  @objc func segmentedControllerDidChange(_ segmentedController: UISegmentedControl) {
    let index = segmentedController.selectedSegmentIndex
    switch index {
    case 1:
      restultType = .popular
    default:
      restultType = .recent
    }
    searchTopics()
  }
  
  func searchTopics() {
    changeUIState(to: .displayingTweets)
    guard let topic = tweetSearchBar.text else { return }
    if topic != "" {
      activityIndicator.start()
      viewModel.search(for: topic, with: restultType)
      dismissKeyboard()
    } else {
      errorFound(with: "Please type a topic")
    }
  }
  
  @objc func dismissKeyboard() {
    tweetSearchBar.resignFirstResponder()
  }
  
  private func configureTweetCellNib() {
    let cellNib = UINib(nibName: Constants.tweetCellNibName, bundle: nil)
    
    if let tweetsResultTableView = tweetsResultTableView {
      tweetsResultTableView.register(cellNib, forCellReuseIdentifier: Constants.tweetCellReuseIdentifier)
    }
  }
  
  private func createTableViewHeader() {
    let frame = CGRect(x: 0, y: 0, width: tweetsResultTableView.frame.width, height: 34)
    let segmentedControl = UISegmentedControl(items: ["Recent", "Popular"])
    segmentedControl.frame = frame
    segmentedControl.selectedSegmentIndex = 0
    segmentedControl.addTarget(self, action: #selector(self.segmentedControllerDidChange(_:)), for: .valueChanged)
    
    tweetsResultTableView.tableHeaderView = segmentedControl
  }
  
  private func changeUIState(to state: UIStates) {
    switch state {
    case .displayingTweets:
      displayTweetResults()
    case .noTweetsFound:
      displayNoTweetsFound()
    }
  }
  
  private func displayTweetResults() {
    tweetsResultTableView.isHidden = false
    noTweetsFoundStackView.isHidden = true
  }
  
  private func displayNoTweetsFound() {
    tweetsResultTableView.isHidden = true
    noTweetsFoundStackView.isHidden = false
  }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tweetsResultTableView.dequeueReusableCell(withIdentifier: Constants.tweetCellReuseIdentifier,
                                                               for: indexPath) as? SearchCardTableViewCell else {
                                                                let cell = UITableViewCell(style: .default, reuseIdentifier: Constants.tweetCellReuseIdentifier)
                                                                return cell
    }
    
    let index = indexPath.item
    cell.profileImageImageView.downloaded(from: tweets[index].user.profile_image_url_https)
    if tweets[index].user.verified {
      cell.verifiedIconImageView.isHidden = false
    } else {
      cell.verifiedIconImageView.isHidden = true
    }
    cell.followersCountLabel.text = viewModel.createCountSuffix(from: tweets[index].user.followers_count)
    cell.friendsCountLabel.text = viewModel.createCountSuffix(from: tweets[index].user.friends_count)
    cell.userNameLabel.text = tweets[index].user.name
    cell.statusTextTextView.text = tweets[index].text
    cell.createdAtLabel.text = tweets[index].created_at
    
    return cell
  }
}

extension SearchViewController: SearchViewable {
  func noTweetsFound() {
    DispatchQueue.main.async {
      self.changeUIState(to: .noTweetsFound)
      self.activityIndicator.stop()
    }
  }
  
  func errorFound(with message: String) {
    let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
  func updateTweets(with results: [Tweet]) {
    tweets = results
    DispatchQueue.main.async {
      self.tweetsResultTableView.reloadData()
      self.activityIndicator.stop()
    }
  }
}

enum UIStates {
  case displayingTweets
  case noTweetsFound
}

enum ResultType {
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
