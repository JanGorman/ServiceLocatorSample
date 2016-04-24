//
//  ServiceLocator.swift
//  ServiceLocator
//
//  Created by Jan GORMAN on 24/04/2016.
//  Copyright © 2016 Jan Gorman. All rights reserved.
//

import Foundation

class PostServiceLocator: NSObject {
  
  lazy var dataSource: PostDataSource = {
    return PostDataSource()
  }()
  
}
