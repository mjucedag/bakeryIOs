//
//  ViewController.swift
//  bakery
//
//  Created by Maria Jose Uceda Garcia on 28/01/2018.
//  Copyright © 2018 Maria Jose Uceda Garcia. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var products:[Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let con = DBConnection()

        self.products = con.getData(table: "product", user: "migue", password: "123") as? [Product] ?? []
        
        self.products.forEach { (product) in
            print(product.description)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

