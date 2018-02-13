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
        mockUrlSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
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
    
    func test_Login_UserExpertQueryParamsWithoutOrder() {
        let completion = { (token: Token?, error: Error?) in }
        sut.loginUser(withName: "phinger", password: "%&1234", completion: completion)
        for queryItem in (mockUrlSession.urlComponents?.queryItems)! {
            if(queryItem.name == "username"){
                XCTAssertEqual(queryItem.value, "phinger".parentEncoded)
            }
            switch queryItem.name{
            case "username": XCTAssertEqual(queryItem.value?.parentEncoded, "phinger".parentEncoded)
            case "password":
                XCTAssertEqual(queryItem.value?.parentEncoded, "%&1234".parentEncoded)
            default: break
            }
        }
    }
    
    func test_Login_WhenSuccessful_CreateToken() {
        let jsonData = "{\"token\":\"1234567890\"}".data(using: .utf8)
        mockUrlSession = MockURLSession(data: jsonData, urlResponse: nil, error: nil)
        sut.session = mockUrlSession
        let tokenExpectation = expectation(description: "Token")
        var caughtToken: Token? = nil
        sut.loginUser(withName: "phinger", password: "123456") { (token, error) in
            caughtToken = token
            tokenExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertEqual(caughtToken?.id, "1234567890")
        }
    }
    
    func test_Login_WhenJSONIsEmpty_ReturnsError(){
        mockUrlSession = MockURLSession(data: Data(), urlResponse: nil, error: nil)
        sut.session = mockUrlSession
        let errorExpectation = expectation(description: "Error")
        var catchedError: Error?
        sut.loginUser(withName: "phinger", password: "123456") { (token, error) in
            catchedError = error
            errorExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(catchedError)
        }
    }
    
    func test_Login_WhenDataIsNil_ReturnsError() {
        mockUrlSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
        sut.session = mockUrlSession
        let errorExceptation = expectation(description: "NilDataExpectation")
        var nilError: Error?
        sut.loginUser(withName: "phinger", password: "123456") { (token, error) in
            nilError = error
            errorExceptation.fulfill()
        }
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(nilError)
        }
    }
    
    func test_Login_WhenResponseHasError_ReturnsError() {
        let error = NSError(domain: "SomeError",
                            code: 1234,
                            userInfo: nil)
        let jsonData =
            "{\"token\": \"1234567890\"}"
                .data(using: .utf8)
        mockUrlSession = MockURLSession(data: jsonData,
                                        urlResponse: nil,
                                        error: error)
        sut.session = mockUrlSession
        let errorExpectation = expectation(description: "Error")
        var catchedError: Error? = nil
        sut.loginUser(withName: "Foo", password: "Bar") { (token, error) in
            catchedError = error
            errorExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(catchedError)
        }
    }
}

extension APIClientTests{
    class MockURLSession: SessionProtocol {
        
        var url: URL?
        private let dataTask: MockTask
        
        var urlComponents: URLComponents?{
            guard let url = url else { return nil }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            dataTask = MockTask(data: data, urlResponse: urlResponse, responseError: error)
        }
        
        func dataTask(with url:URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            dataTask.completionHandler = completionHandler
            return dataTask
        }
    }
    
    class MockTask: URLSessionDataTask{
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?
        
        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        
        var completionHandler: CompletionHandler?
        
        init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = responseError
        }
        
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler?(self.data, self.urlResponse, self.responseError)
            }
        }
    }
}
