//
//  SearchViewController.swift
//  Twieker
//
//  Created by Janco Erasmus on 2020/07/29.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
  @IBOutlet var tweetSearchBar: UISearchBar!
  @IBOutlet var tweetsResultTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tweetsResultTableView.delegate = self
    tweetsResultTableView.dataSource = self
    configureTweetCellNib()
  }
  
  private func configureTweetCellNib() {
    let cellNib = UINib(nibName: Constants.tweetCellNibName, bundle: nil)
    
    if let tweetsResultTableView = tweetsResultTableView {
      tweetsResultTableView.register(cellNib, forCellReuseIdentifier: Constants.tweetCellReuseIdentifier)
    }
  }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tweetsResultTableView.dequeueReusableCell(withIdentifier: Constants.tweetCellReuseIdentifier,
                                                               for: indexPath) as? SearchCardTableViewCell else {
                                                                let cell = UITableViewCell(style: .default, reuseIdentifier: Constants.tweetCellReuseIdentifier)
                                                                return cell
    }
    
    return cell
  }
}
