//
//  Extensions.swift
//  Twieker
//
//  Created by Janco Erasmus on 2020/07/30.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  func addShadow() {
    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOpacity = 0.8
    self.layer.shadowOffset = .zero
    self.layer.shadowRadius = 2
  }
}

extension UIImageView {
  func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data)
        else { return }
      DispatchQueue.main.async() { [weak self] in
        self?.image = image
      }
    }.resume()
  }
}

extension UIActivityIndicatorView {
  func start() {
    self.startAnimating()
    self.isHidden = false
  }
  
  func stop() {
    self.stopAnimating()
    self.isHidden = true
  }
}
