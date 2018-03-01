import Foundation
import UIKit

class DBConnection{
    
    private let dbURL = "https://bakery-server-franor21.c9users.io/";
    private var token:String = ""
    
    func getData(table: String, user: String, password: String, extra:String = "-1") -> Any{
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
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any]
                    print(json)
                    self.token = json["t"] as? String ?? ""
                    
                    print("Token: \(self.token)")
                    
                    let results = json["r"] as? [[String:Any]] ?? nil
                    results?.forEach{ row in
                        products.append( Product(json: row)!)
                    }
                }catch {
                    print("error")
                }
                }.resume()
        }
        return products
    }
    
    func postData(table: String, extra: String) {
        var urlString = dbURL
        urlString += table
        guard let urlCon = URL(string: urlString) else {return }
        
        let request = NSMutableURLRequest(url: urlCon)
        
        let data = "migue:123".data(using: .utf8)
        let author = data!.base64EncodedString()
        
        request.setValue("Basic \(author)", forHTTPHeaderField: "Authorization")
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
                    self.token = json["t"] as? String ?? ""
                    
                    print("Token: \(self.token)")
                    
                    let results = json["r"] as? [[String:Any]] ?? nil
                    
                }catch {
                    print("error")
                }
                }.resume()
        }
    }
}
