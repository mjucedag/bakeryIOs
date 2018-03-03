//
//  DataBase.swift
//  bakery
//
//  Created by dam on 1/3/18.
//  Copyright © 2018 Maria Jose Uceda Garcia. All rights reserved.
//

import UIKit

class DataBase {
    public static var products:[Product] = []
    public static var cart:Ticket? = nil
    static var member = 0
    static var user = ""
    static var pass = ""
    public static var token = ""
    
    public static func setCredentials(user:String, pass:String){
        self.user = user
        self.pass = pass
    }
    
    public static func getCredentials()->String{
        let data = "\(user):\(pass)".data(using: .utf8)
        let member = data!.base64EncodedString()
        return member
    }
}


