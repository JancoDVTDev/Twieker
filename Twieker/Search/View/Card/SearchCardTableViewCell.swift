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
  @IBOutlet var profileBackgroundImageImageView: UIImageView!
  @IBOutlet var profileImageImageView: UIImageView!
  @IBOutlet var userNameLabel: UILabel!
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
    
    profileBackgroundImageImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    profileBackgroundImageImageView.layer.cornerRadius = cardRadius
    profileBackgroundImageImageView.clipsToBounds = true
    profileBackgroundImageImageView.alpha = 0.3
    
    profileImageImageView.layer.cornerRadius = profileImageImageView.frame.height/2
    profileImageImageView.layer.masksToBounds = true
    profileImageImageView.addShadow()
  }
}
