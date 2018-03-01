//
//  Product.swift
//  bakery
//
//  Created by dam on 16/2/18.
//  Copyright © 2018 Maria Jose Uceda Garcia. All rights reserved.
//

import Foundation

struct Product: Hashable{
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id && lhs.idFamily == rhs.idFamily && lhs.name == rhs.name && lhs.price == rhs.price && lhs.description == rhs.description
    }
    
    var hashValue: Int{
        return (id+idFamily).hashValue
    }
    
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
    
    init(id: Int, idFamily: Int, name: String, price: Double, description: String){
        
        self.id = id
        self.idFamily = idFamily
        self.name = name
        self.price = price
        self.description = description
    }
    
    
}
