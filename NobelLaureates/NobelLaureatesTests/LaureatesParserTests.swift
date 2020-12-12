//
//  LaureatesParserTests.swift
//  NobelLaureatesTests
//
//  Created by Karandeep Singh Bhatia on 12/12/20.
//

import XCTest
@testable import NobelLaureates

class LaureatesParserTests: XCTestCase {
  
  override func setUp() {
    
  }
  
  func testSuccessParseResponse()  {
    let resource = Resource(jsonName: "nobel-prize-laureates")
    let laureatesParser = LaureatesParser()
    laureatesParser.parseLaureateResponse(resource: resource) { (result) in
      switch result {
        case.success(let model):
          XCTAssertNotNil(model)
        case .failure:
          XCTFail()
      }
    }
  }
  
  func testFailureParseResponse()  {
    let resource = Resource(jsonName: "incorrect-json-name")
    let laureatesParser = LaureatesParser()
    laureatesParser.parseLaureateResponse(resource: resource) { (result) in
      switch result {
        case.success:
          XCTFail("Expected Failure")
        case .failure(let error):
          XCTAssertNotNil(error)
      }
    }
  }
  
}
