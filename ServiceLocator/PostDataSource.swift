//
//  PostsDataSource.swift
//  ServiceLocator
//
//  Created by Jan GORMAN on 24/04/2016.
//  Copyright © 2016 Jan Gorman. All rights reserved.
//

import UIKit



protocol TableViewDataSource {
  
  associatedtype ItemType
  
  var items: [ItemType] { get }
  
  func load(completion: (error: NSError?) -> Void)
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell

}

extension TableViewDataSource {

  func itemInRow(row: Int) -> ItemType {
    return items[row]
  }

}

class PostDataSource: TableViewDataSource {

  private static let UrlString = "http://jsonplaceholder.typicode.com/posts"

  private let session: NSURLSession
  private var task: NSURLSessionDataTask?
  
  var items: [Post]
  
  deinit {
    task?.cancel()
  }
  
  init(session: NSURLSession = NSURLSession.sharedSession()) {
    self.session = session
    items = []
  }

  func load(completion: (error: NSError?) -> Void) {
    task = session.dataTaskWithURL(NSURL(string: PostDataSource.UrlString)!) { [weak self] data, _, error in
      defer {
        NSOperationQueue.mainQueue().addOperationWithBlock {
          completion(error: error)
        }
      }
      guard let data = data,
                json = try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [NSDictionary],
                dict = json
          where error == nil else { return }
      self?.items = dict.map { Post(dictionary: $0) }
    }
    task?.resume()
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell))!
    cell.textLabel?.text = items[indexPath.row].title
    return cell
  }

}
