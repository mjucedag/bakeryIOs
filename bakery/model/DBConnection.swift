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
    
    func connect(){
        
        let credentials = DataBase.getCredentials()
        let urlString = dbURL + "login"
        guard let urlCon = URL(string: urlString) else {return}
        let request = NSMutableURLRequest(url: urlCon)
        
        request.setValue("Basic \(credentials)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
    }
    
    func getData(table: String, user: String, password: String,  products: inout [Product]) {
        var urlString = dbURL
        urlString += table
        guard let urlCon = URL(string: urlString) else {return}
        
        let request = NSMutableURLRequest(url: urlCon)
        
        
        let credentials = DataBase.getCredentials()
        request.setValue("Bearer \(DataBase.token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        let results = query(request: request )
        results.forEach{ row in
            DataBase.products.append( Product(json: row)!)
        }
    }
    
    func query(request:NSMutableURLRequest) -> [[String:Any]]{
        let group = DispatchGroup()
        let colaGlobal = DispatchQueue.global()
        group.enter()
        var results:[[String:Any]] = [[:]]
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
                    DataBase.token = json["t"] as? String ?? ""
                    
                    results = json["r"] as? [[String:Any]] ?? [[:]]
                    
                }catch {
                    return
                }
                group.leave()
                }.resume()
        }
        group.wait()
        return results
    }
    
    func postTicket(extra: String) {
        var urlString = dbURL
        urlString += "ticket"
        guard let urlCon = URL(string: urlString) else {return}
        
        let request = NSMutableURLRequest(url: urlCon)
        
        request.setValue("Bearer \(DataBase.token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        
        request.httpBody = extra.data(using: .utf8)
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        let colaGlobal = DispatchQueue.global()
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
                    print("json:\(json)")
                    DataBase.token = json["t"] as? String ?? ""
                    
                    let results = json["r"] as? [[String:Any]] ?? nil
                    print(results)
                }catch {
                    print("error")
                }
                }.resume()
        }
    }
    
    
}
