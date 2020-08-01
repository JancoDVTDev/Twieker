//
//  SearchResponse.swift
//  Twieker
//
//  Created by Janco Erasmus on 2020/08/01.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
  var statuses: [Tweet]
}
