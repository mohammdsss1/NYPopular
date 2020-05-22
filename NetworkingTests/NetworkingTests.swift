//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by Hammoda on 5/22/20.
//  Copyright © 2020 salah. All rights reserved.
//

import XCTest
@testable import Networking
//@testable import NYPopular

struct SimpleArticle: Codable{
    var id = 0
    
    enum CodingKeys: String, CodingKey {
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
    }
}

class NetworkingTests: XCTestCase {
    var apiHandler: APIHandeler!
    
    override func setUp() {
        apiHandler = APIHandeler()
    }

    override func tearDown() {
        apiHandler = nil
    }
    
    func testArticlesRequest() {
        let expectation = self.expectation(description: "articles")
        apiHandler.request(endPoint: EndPoint.mostPopular(period: "1")) { (result: Result<[SimpleArticle], NetworkLayer.ErrorModel>) in
            switch result {
            case .success(let articles):
                XCTAssertFalse(articles.isEmpty)
            case .failure(_):
                assertionFailure()
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5.0) { error in
            if let error = error {
                print("\(error)")
            }
        }
    }
}
