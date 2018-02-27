//
//  Product.swift
//  bakery
//
//  Created by dam on 16/2/18.
//  Copyright © 2018 Maria Jose Uceda Garcia. All rights reserved.
//

import Foundation

struct Product{
    var id: Int
    var idFamily: Int
    var name: String
    var price: Double
    var description: String
    
    init?(json:Any){
        guard let json = json as? [String:Any] else{return nil}
        id = json["id"] as? Int ?? -1
        idFamily = json["idfamily"] as? Int ?? -1
        name = json["product"] as? String ?? "noname"
        price = json["price"] as? Double ?? -1
        description = json["description"] as? String ?? "No description for this product"
    }
    
    
}
