struct Product: Hashable{
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id && lhs.idFamily == rhs.idFamily && lhs.name == rhs.name && lhs.price == rhs.price && lhs.description == rhs.description
    }
    
    var hashValue: Int{
        return (id+idFamily).hashValue
    }
    
    var id: String
    var idFamily: String
    var name: String
    var price: String
    var description: String
    
    init?(json:Any){
        guard let json = json as? [String:Any] else{return nil}
        id = json["id"] as? String ?? "-1"
        idFamily = json["idfamily"] as? String ?? "-1"
        name = json["product"] as? String ?? "noname"
        price = json["price"] as? String ?? "-1"
        description = json["description"] as? String ?? "No description for this product"
    }
    
    init(id: String, idFamily: String, name: String, price: String, description: String){
        
        self.id = id
        self.idFamily = idFamily
        self.name = name
        self.price = price
        self.description = description
    }
    
    
}
