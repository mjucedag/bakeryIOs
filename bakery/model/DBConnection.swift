//
//  DBConnection.swift
//  bakery
//
//  Created by mjuceda on 27/2/18.
//  Copyright © 2018 Maria Jose Uceda Garcia. All rights reserved.
//

import Foundation
import UIKit

class DBConnection{
    
    private let dbURL = "https://bakery-server-franor21.c9users.io/";
    private var token:String = ""
    
    
    func getData(table: String, user: String, password: String,  products: inout [Product]) {
        var urlString = dbURL
        urlString += table
        guard let urlCon = URL(string: urlString) else {return}
        
        let request = NSMutableURLRequest(url: urlCon)
        
        let data = "\(user):\(password)".data(using: .utf8)
        let author = data!.base64EncodedString()
        
        request.setValue("Basic \(author)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        let group = DispatchGroup()
        let colaGlobal = DispatchQueue.global()
        group.enter()
        colaGlobal.async {
            defer{
                DispatchQueue.main.async{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
            
            URLSession.shared.dataTask(with: request as URLRequest){ (data, response, error) in
                guard let data = data else{return}
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any]
                    self.token = json["t"] as? String ?? ""
                    
                    let results = json["r"] as? [[String:Any]] ?? nil
                    results?.forEach{ row in
                        products.append( Product(json: row)!)
                    }
                }catch {
                    
                }
                group.leave()
                }.resume()
        }
        group.wait()
    }
    
    func checkToken()->Bool{
        return token != ""
    }
    
    
}
