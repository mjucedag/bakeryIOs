/*
{
 "date" : "13/12/1992",
 "member": 2,
 "details" :[
     {
     "product": 1,
     "quantity": 1,
     "price": 1
     },
     {
     "product": 2,
     "quantity": 3,
     "price": 14
     }
 ]
}
*/

class Ticket{
    var date : String
    var member : Int
    var products: [Product:Int]
    
    init(date: String, member: Int, products: [Product:Int]){
        self.date = date
        self.member = member
        self.products = products
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
