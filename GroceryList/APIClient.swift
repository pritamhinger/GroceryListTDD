//
//  APIClient.swift
//  GroceryList
//
//  Created by Pritam Hinger on 01/02/18.
//  Copyright © 2018 AppDevelapp. All rights reserved.
//

import Foundation

class APIClient {
    lazy var session: SessionProtocol = URLSession.shared
    
    func loginUser(withName: String, password: String, completion: @escaping(Token?, Error?)-> Void) {
        
        let query = "username=\(withName.parentEncoded)&password=\(password.parentEncoded)"
        
        guard let url = URL(string: "https://awesometodos.com/login?\(query)") else{ fatalError() }
        
        _ = session.dataTask(with: url) { (data, response, error) in
            if let error = error{
                print("Error logging in into the app", error)
                return
            }
            
            print(response ?? "")
            print(data ?? "")
        }
    }
}

extension URLSession : SessionProtocol{
    
}

extension String{
    var parentEncoded:String{
        let allowedCharacters = CharacterSet(
            charactersIn:
            "/%&=?$#+-~@<>|\\*,.()[]{}^!").inverted
        guard let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else{ fatalError() }
        return encodedString
    }
}

protocol SessionProtocol {
    func dataTask(with url:URL, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
