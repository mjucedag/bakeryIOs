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
    @IBOutlet weak var tramitarButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var productsKeys = Array<Product>()
     
    override func viewDidLoad() {
        super.viewDidLoad()
               
        tableView.delegate = self
        tableView.dataSource = self
        
        productsKeys = Array(DataBase.cart.products.keys)
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
        tramitarButton.isEnabled = productsKeys.count > 0
        deleteButton.isHidden = !tramitarButton.isEnabled
        totalCartLabel.text = String(format: "Total: %.2f€", DataBase.cart.total)
        tableView.reloadData()
    }
    
    func exitoVenta(_ sender: Any) {
        let alert = UIAlertController(title: "Venta realizada con exito", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cerrar ventana", style: .default) { (action) in}
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tramitar(_ sender: Any) {
        let con = DBConnection()
        con.postTicket(extra: DataBase.cart.toJson())
        DataBase.cart = Ticket()
        refresh()
        exitoVenta("")
    }
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataBase.cart.products.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let p = productsKeys[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ticketCell") as! TicketTableViewCell
        cell.setProduct(p)
        cell.drawShadow()
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }

    // Override to support conditional rearranging of the table view.
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Borrar") { (action, indexPath) in
            DataBase.cart.products.removeValue(forKey: self.productsKeys[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.refresh()
        }
        return [delete]
    }
    
    //alerta para confirmar el borrado del ticket
    @IBAction func confirmDeleteTicket(_ sender: UIButton) {
        let actionSheet = UIAlertController(title:"¿Estás seguro/a de borrar el ticket?", message: "No podrás recuperarlo una vez borrado", preferredStyle: UIAlertControllerStyle.actionSheet)
        let deleteAction = UIAlertAction(title:"Borrar ticket", style:UIAlertActionStyle.destructive) { (alert:UIAlertAction) -> Void in DataBase.cart = Ticket()
            self.refresh()
        }
        let cancelAction = UIAlertAction(title:"Cancelar borrado", style:UIAlertActionStyle.cancel) { (alert:UIAlertAction) -> Void in print("Cancel pressed")}
            
        actionSheet.addAction(deleteAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
 }
}
