//
//  NYPopularTests.swift
//  NYPopularTests
//
//  Created by Hammoda on 5/22/20.
//  Copyright © 2020 salah. All rights reserved.
//

import XCTest
@testable import NYPopular

class NYPopularTests: XCTestCase {
    var articlesViewModel: ArticlesViewModel!
    
    override func setUp() {
        articlesViewModel = ArticlesViewModel()
    }

    override func tearDown() {
        articlesViewModel = nil
    }

    func testArticlesViewModel() {
        let expectation = self.expectation(description: "articles")
        articlesViewModel.getMostPopularArticles(withPeriod: .one, success: { articles in
            expectation.fulfill()
            XCTAssert(!articles.isEmpty)
        }, failure: { error in
            assertionFailure()
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10.0) { error in
            if let error = error {
                print("\(error)")
            }
        }
    }
}
