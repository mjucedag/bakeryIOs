//
//  TicketTableViewController.swift
//  bakery
//
//  Created by Hate on 04/03/2018.
//  Copyright © 2018 Maria Jose Uceda Garcia. All rights reserved.
//

import UIKit

class TicketTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var totalCartLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var productsKeys = Array<Product>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        productsKeys = Array(DataBase.cart.products.keys)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataBase.cart.products.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let p = productsKeys[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ticketCell") as! TicketTableViewCell
        cell.setProduct(p)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        refresh()
    }
    
    @objc func refresh(){
        productsKeys = Array(DataBase.cart.products.keys)
        
        totalCartLabel.text = String(format: "Total: %.2f€", DataBase.cart.total)
        tableView.reloadData()
    }
    @IBAction func tramitar(_ sender: Any) {
        let con = DBConnection()
        con.postTicket(extra: DataBase.cart.toJson())
        DataBase.cart = Ticket()
        refresh()
    }
    
    // MARK: - Table view data source

    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
