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
        var tick = Ticket(date: "10/10/2010", member: 3, products: [Product( id: 1, idFamily: 1, name: "tst", price: 12.00, description: "prueba" ):2] )
        print(tick.toJson())
        //let json = try? JSONEncoder().encode(Ticket(date: "10/10/2010",member:  2))
        con.postData(table: "ticket", extra: tick.toJson())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

