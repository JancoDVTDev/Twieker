//
//  SearchCardTableViewCell.swift
//  Twieker
//
//  Created by Janco Erasmus on 2020/07/29.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class SearchCardTableViewCell: UITableViewCell {
  
  @IBOutlet var cardBackgroundView: UIView!
  @IBOutlet var coverHeaderView: UIView!
  @IBOutlet var profileImageImageView: UIImageView!
  @IBOutlet var verifiedIconImageView: UIImageView!
  @IBOutlet var userNameLabel: UILabel!
  @IBOutlet var followersCountLabel: UILabel!
  @IBOutlet var friendsCountLabel: UILabel!
  @IBOutlet var statusTextTextView: UITextView!
  @IBOutlet var createdAtLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    styleCard()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  private func styleCard() {
    
    let cardRadius = CGFloat(6)
    
    cardBackgroundView.layer.cornerRadius = cardRadius
    cardBackgroundView.addShadow()
    
    coverHeaderView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    coverHeaderView.layer.cornerRadius = cardRadius
    coverHeaderView.clipsToBounds = true
    coverHeaderView.alpha = 0.5
    
    profileImageImageView.layer.cornerRadius = profileImageImageView.frame.height/2
    profileImageImageView.layer.masksToBounds = true
    profileImageImageView.addShadow()
  }
}
