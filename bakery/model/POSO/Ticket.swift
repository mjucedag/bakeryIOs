struct Ticket{
    var date : String = ""
    var member : Int
    var products: [Product:Int]
    
    init(member: Int){
        self.member = member
        self.products = [Product:Int]()
    }
    
    func toJson() ->String{
        let prod = productsToString()
        return "{\"date\": \"\(date)\", \"member\": \"\(member)\", \"details\": [\(prod)]}"
    }
    
    func productsToString() ->String{
        var output = ""
        products.forEach({
            (pr) in
            output += "{\"product\": \(pr.key.id), \"quantity\": \(pr.value), \"price\": \(pr.key.price * Double(pr.value))},"
        })
        output = String(output.prefix(output.count-1))
        return output
    }
}
