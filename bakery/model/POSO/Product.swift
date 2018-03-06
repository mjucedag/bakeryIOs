import UIKit

class Product: Hashable{
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
    var image:UIImage
    
    init?(json:Any){
        guard let json = json as? [String:Any] else{return nil}
        id = Int(json["id"] as? String ?? "-1")!
        idFamily = Int(json["idfamily"] as? String ?? "-1")!
        name = json["product"] as? String ?? "noname"
        price = Double(json["price"] as? String ?? "-1")!
        description = json["description"] as? String ?? "No description for this product"
        image = UIImage(named: "logo")!
//        downloadImage()
    }
    
    init(id: Int, idFamily: Int, name: String, price: Double, description: String){
        
        self.id = id
        self.idFamily = idFamily
        self.name = name
        self.price = price
        self.description = description
        image = UIImage(named: "logo")!
//        downloadImage()
    }
    
    func downloadImage(){
        let urlImage = "https://bakery-server-franor21.c9users.io/bakeryPhotos/\(id).jpg"
        guard let url = URL(string: urlImage) else{print("error en \(id)");return}
        let group = DispatchGroup()
        group.enter()
        let thread = DispatchQueue(label: "imageDownload", qos: .default, attributes: .concurrent)
        thread.async{
            guard let data = try? Data(contentsOf: url),
                let img = UIImage(data: data) else{
                    group.leave();
                    return
            }
            self.image = img
            group.leave()
        }
        group.wait()
    }
}
