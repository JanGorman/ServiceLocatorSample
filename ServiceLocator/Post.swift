//
//  Post.swift
//  ServiceLocator
//
//  Created by Jan GORMAN on 24/04/2016.
//  Copyright © 2016 Jan Gorman. All rights reserved.
//

import Foundation

struct Post {
  
  let userId: Int
  let id: Int
  let title: String
  let body: String
  
  init(dictionary: NSDictionary) {
    userId = dictionary["userId"] as! Int
    id = dictionary["id"] as! Int
    title = dictionary["title"] as! String
    body = dictionary["body"] as! String
  }
  
}
