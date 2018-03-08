import Foundation
import UIKit

class DBConnection{
    
    private let dbURL = "https://bakery-server-franor21.c9users.io/";
    public var conError = 200
    
    func connect()->Bool{
        let credentials = DataBase.getCredentials()
        let urlString = dbURL + "login"
        guard let urlCon = URL(string: urlString) else {return false}
        let request = NSMutableURLRequest(url: urlCon)
        
        request.setValue("Basic \(credentials)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        _ = query(request)
        print(conError)
        return conError == 200
    }
    
    func getData(table: String) -> [[String:Any]] {
        var urlString = dbURL
        urlString += table
        guard let urlCon = URL(string: urlString) else {return [[:]]}
        
        let request = NSMutableURLRequest(url: urlCon)
        
        request.setValue("Bearer \(DataBase.token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        return query(request)
    }
    
    func getProducts(){
        let results = getData(table:"product")
        results.forEach{ row in
            DataBase.products.append( Product(json: row)!)
        }
    }
    
    
    func getTickets(date:String) ->[[String:Any]]{
        let tickets = getData(table:"ticket?date=\(date)")
        return getTickets(data: tickets)
    }
    
    func getTickets(member:Int) ->[[String:Any]]{
        let tickets = getData(table:"ticket?idmember=\(member)")
        return getTickets(data: tickets)
    }
    
    func getTickets(cat:Int)->[[String:Any]]{
        let tickets = getData(table: "ticketcategory?id=\(cat)")
        return getTickets(data: tickets)
    }
    
    func getTickets(data: [[String:Any]])->[[String:Any]]{
        var data = data
        data.enumerated().forEach{ k,t in
            let idTicket = t["id"]
            
            if idTicket != nil {
                let details = getData(table:"ticketdetail?idticket=\(idTicket!)")
                var total:Double = 0
                details.forEach{d in
                    total += Double(d["price"] as? String ?? "0.00")!
                }
                data[k]["total"] = total
            }
        }
        return data
    }
    
    func postTicket(extra: String) {
        var urlString = dbURL
        urlString += "ticket"
        guard let urlCon = URL(string: urlString) else {return}
        
        let request = NSMutableURLRequest(url: urlCon)
        
        request.setValue("Bearer \(DataBase.token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        
        request.httpBody = extra.data(using: .utf8)
        
        _ = query(request)
    }
    
    func query(_ request:NSMutableURLRequest) -> [[String:Any]]{
        let group = DispatchGroup()
        let colaGlobal = DispatchQueue.global()
        group.enter()
        var results:[[String:Any]] = [[String:Any]]()
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
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
                    if json["e"] != nil{
                        self.conError = Int(json["e"] as? String ?? "0")!
                        group.leave()
                        return
                    }
                    
                    if json["m"] != nil{ DataBase.member = Int(json["m"] as? String ?? "-1")! }
                    
                    DataBase.token = json["t"] as? String ?? ""
                    
                    results = json["r"] as? [[String:Any]] ?? [[:]]
                    
                }catch {
                    group.leave()
                    return
                }
                group.leave()
                }.resume()
            
        }
        group.wait()
        return results
    }
    
    public func getError()->String{
        switch conError {
            case 0: return "Error"
            
            case 402: return "Failed login"
            
            case 404: return "Not found"
            
            case 501:  return "Incorrect token"
            
            case 502: return "Token expired"
            default: return ""
        }
    }
    
}
