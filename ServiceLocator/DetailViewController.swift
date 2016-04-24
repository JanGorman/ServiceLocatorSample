//
//  DetailViewController.swift
//  ServiceLocator
//
//  Created by Jan GORMAN on 24/04/2016.
//  Copyright © 2016 Jan Gorman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet private var bodyLabel: UILabel! {
    didSet {
      bodyLabel.text = post.body
    }
  }

  var post: Post! {
    didSet {
      title = post.title
    }
  }

}
