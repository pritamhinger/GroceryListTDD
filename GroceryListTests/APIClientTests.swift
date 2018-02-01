//
//  APIClientTests.swift
//  GroceryListTests
//
//  Created by Pritam Hinger on 01/02/18.
//  Copyright © 2018 AppDevelapp. All rights reserved.
//

import XCTest
@testable import GroceryList

class APIClientTests: XCTestCase {
    
    var sut: APIClient!
    var mockUrlSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        sut = APIClient()
        mockUrlSession = MockURLSession()
        sut.session = mockUrlSession
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_Login_UserExpextedHost() {
        
        let completion = { (token: Token?, error: Error?) in }
        sut.loginUser(withName: "phinger", password: "1234", completion: completion)
        
        XCTAssertEqual(mockUrlSession.urlComponents?.host, "awesometodos.com")
    }
    
    func test_Login_UserExpextedPath() {
        
        let completion = { (token: Token?, error: Error?) in }
        sut.loginUser(withName: "phinger", password: "1234", completion: completion)
        
        XCTAssertEqual(mockUrlSession.urlComponents?.path, "/login")
    }
    
    func test_Login_UserExpextedQueryParams() {
        
        let completion = { (token: Token?, error: Error?) in }
        sut.loginUser(withName: "phinger", password: "%&1234", completion: completion)
        
         XCTAssertEqual(mockUrlSession.urlComponents?.percentEncodedQuery, "username=phinger&password=%25%261234")
    }
}

extension APIClientTests{
    class MockURLSession: SessionProtocol {
        
        var url: URL?
        
        var urlComponents: URLComponents?{
            guard let url = url else { return nil }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        func dataTask(with url:URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            return URLSession.shared.dataTask(with: url)
        }
    }
}
