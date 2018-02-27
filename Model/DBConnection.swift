import Foundation
import UIKit

class DBConnection{
    
    private let dbURL = "https://bakery-server-franor21.c9users.io/";
    private var token:String = ""
    
    public  enum ConError: Error {
        case LoginFailed
    }
    
    func getData(table: String, user: String, password: String, _ callback:@escaping (Bool)->Void, extra:String = "-1") -> Any {
        var urlString = dbURL
        urlString += table
        guard let urlCon = URL(string: urlString) else {return "404"}
        
        let request = NSMutableURLRequest(url: urlCon)
        
        let data = "\(user):\(password)".data(using: .utf8)
        let author = data!.base64EncodedString()
        
        request.setValue("Basic \(author)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        var products:[Product] = []
        
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
                var er = false
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any]
                    if json["e"] != nil {
                        er = true
                    }
                    self.token = json["t"] as? String ?? ""
                    
                    let results = json["r"] as? [[String:Any]] ?? nil
                    results?.forEach{ row in
                        products.append( Product(json: row)!)
                    }
                }catch {
                    er = true
                }
                callback(er)
            }.resume()
            
        }
        
        return products
    }
    
    func checkToken()->Bool{
        return token != ""
    }
    
    
}
