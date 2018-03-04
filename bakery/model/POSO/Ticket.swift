import Foundation

struct Ticket{
    var date : String {
        get{
            let date = Date()
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy/MM/dd"
            return dateFormat.string(from: date)
        }
    }
    var member : Int
    var products: [Product:Int]
    var total:Double {
        get{
            var out:Double = 0.00
            products.forEach{p in
                out += Double(p.value) * p.key.price
            }
            return out
        }
    }
    init(){
        self.member = DataBase.member
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
