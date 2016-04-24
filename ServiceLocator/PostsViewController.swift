//
//  ViewController.swift
//  ServiceLocator
//
//  Created by Jan GORMAN on 24/04/2016.
//  Copyright © 2016 Jan Gorman. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

  @IBOutlet private var serviceLocator: PostServiceLocator!
  @IBOutlet private var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    load()
  }
  
  private func load() {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    serviceLocator.dataSource.load { [weak self] error in
      defer {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
      }
      self?.tableView.reloadData()
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let indexPath = tableView.indexPathForSelectedRow where segue.identifier == "ShowDetail" else { return }
    let post = serviceLocator.dataSource.itemInRow(indexPath.row)
    (segue.destinationViewController as? DetailViewController)?.post = post
  }

}

extension PostsViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return serviceLocator.dataSource.tableView(tableView, numberOfRowsInSection: section)
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return serviceLocator.dataSource.tableView(tableView, cellForRowAtIndexPath: indexPath)
  }
  
}
