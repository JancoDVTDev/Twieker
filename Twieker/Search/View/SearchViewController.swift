//
//  SearchViewController.swift
//  Twieker
//
//  Created by Janco Erasmus on 2020/07/29.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit
class SearchViewController: UIViewController, UISearchBarDelegate {
  @IBOutlet private var tweetSearchBar: UISearchBar!
  @IBOutlet private var tweetsResultTableView: UITableView!
  @IBOutlet private var activityIndicator: UIActivityIndicatorView!
  @IBOutlet private var noTweetsFoundStackView: UIStackView!
  
  private lazy var viewModel = SearchViewModel()
  private var filterType: FilterType = .recent
  private var initialTopic = "Covid 19"
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    displayInitialTweets()
  }
      
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchTopics()
  }
  
  @objc func segmentedControllerDidChange(_ segmentedController: UISegmentedControl) {
    let index = segmentedController.selectedSegmentIndex
    switch index {
    case 1:
      filterType = .popular
    default:
      filterType = .recent
    }
    searchTopics()
  }
  
  private func searchTopics() {
    changeUIState(to: .displayingTweets)
    guard let topic = tweetSearchBar.text else { return }
    if topic != "" {
      activityIndicator.start()
      viewModel.search(for: topic, with: filterType)
      dismissKeyboard()
    } else {
      displayError(with: "Please type a topic")
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
  
  private func createSegmentedControl() -> UIView {
    let frame = CGRect(x: 0, y: 0, width: tweetsResultTableView.frame.width, height: 34)
    let segmentedControl = UISegmentedControl(items: ["Recent", "Popular"])
    segmentedControl.frame = frame
    segmentedControl.selectedSegmentIndex = 0
    segmentedControl.addTarget(self, action: #selector(segmentedControllerDidChange), for: .valueChanged)
    
    return segmentedControl
  }
  
  private func setup() {
    activityIndicator.isHidden = true
    
    let onViewTap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    self.view.addGestureRecognizer(onViewTap)
    
    viewModel.view = self
            
    tweetSearchBar.delegate = self
    tweetsResultTableView.delegate = self
    tweetsResultTableView.dataSource = self
    
    let segmentedControl = createSegmentedControl()
    tweetsResultTableView.tableHeaderView = segmentedControl
    
    configureTweetCellNib()
  }
  
  private func displayInitialTweets() {
    tweetSearchBar.text = initialTopic
    searchTopics()
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
    return viewModel.tweets.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tweetsResultTableView.dequeueReusableCell(withIdentifier: Constants.tweetCellReuseIdentifier,
                                                               for: indexPath) as? SearchCardTableViewCell else {
                                                                let cell = UITableViewCell(style: .default, reuseIdentifier: Constants.tweetCellReuseIdentifier)
                                                                return cell
    }
    
    let tweet = viewModel.getTweet(indexPath: indexPath)
    cell.profileImageImageView.downloaded(from: tweet.user.profileImageUrl)
    if tweet.user.verified {
      cell.verifiedIconImageView.isHidden = false
    } else {
      cell.verifiedIconImageView.isHidden = true
    }
    cell.followersCountLabel.text = tweet.user.followersCount.stringSuffix()
    cell.friendsCountLabel.text = tweet.user.friendsCount.stringSuffix()
    cell.userNameLabel.text = tweet.user.name
    cell.statusTextTextView.text = tweet.text
    cell.createdAtLabel.text = tweet.createdAt
    
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
  
  func displayError(with message: String) {
    let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
  func tweetsFound() {
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
