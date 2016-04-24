//
//  ServiceLocatorTests.swift
//  ServiceLocatorTests
//
//  Created by Jan GORMAN on 24/04/2016.
//  Copyright © 2016 Jan Gorman. All rights reserved.
//

import XCTest
@testable import ServiceLocator

class PostDataSourceTests: XCTestCase {
  
  class MockDataTask: NSURLSessionDataTask {
    
    var resumeCount = 0
    
    override func resume() {
      resumeCount += 1
    }
  
    override func cancel() {
    }
    
  }
  
  class MockSession: NSURLSession {
    
    var task: MockDataTask!
    
    override func dataTaskWithURL(url: NSURL, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
      let file = NSBundle(forClass: PostDataSourceTests.self).URLForResource("posts", withExtension: "json")
      let rawPosts = NSData(contentsOfURL: file!)
      completionHandler(rawPosts, nil, nil)
      return task
    }
    
  }
  
  override func setUp() {
    super.setUp()
  }
  
  func testLoadSetsPosts() {
    let task = MockDataTask()
    let session = MockSession()
    session.task = task
    let dataSource = PostDataSource(session: session)
    
    dataSource.load { error in
      XCTAssertNil(error)
    }
    XCTAssertEqual(3, dataSource.items.count)
    XCTAssertEqual(1, task.resumeCount)
  }
  
}
