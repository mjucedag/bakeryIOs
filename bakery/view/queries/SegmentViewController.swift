//
//  SegmentViewController.swift
//  bakery
//
//  Created by Maria Jose Uceda Garcia on 04/03/2018.
//  Copyright © 2018 Maria Jose Uceda Garcia. All rights reserved.
//

import UIKit

class SegmentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var mySegmentegControl: UISegmentedControl!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var selectedDate: UILabel!
    @IBOutlet weak var totalTicket: UILabel!
    
    var dailyList:[String] = [] //tuplas de la consulta de tickets por dia
    var memberTicketsList:[String] = [String]() //tuplas de la consulta de tickets por empleado
    var familyTicketsList:[String] = [String]() //tuplas de la consulta de tickets por familia
    
    public static var selectedDate = ""
    public static var selectedCategory: Int = 0
    var selectedMember = 3
    
    var totalMembers:Double = 0.00
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        
        let result = DBConnection().getTickets(member: selectedMember)
        result.forEach{ r in
            totalMembers += r["total"] as! Double
            memberTicketsList.append(String(format: "\t\tId:\t\(r["id"]!) \t Fecha: \(r["date"]!) \t Total: %.2f€", r["total"] as! Double))
        }
        print("tuplas \(result.count) membTickerts: \(memberTicketsList)")
        
        if(!SegmentViewController.selectedDate.isEmpty){
            //Call API Rest
        
            let result = DBConnection().getTickets(date: SegmentViewController.selectedDate)
            if result.isEmpty == true {
                dailyList = []
                noQueryAlert("") //llama cuando no hay consulta
            }else{
                var totalTicket = 0.0
                dailyList = []
                for r in result {
                    let total = r["total"]
                    totalTicket += total as! Double
                    let id = r["id"]
                    let str = "\t\tId: \t\t" + String(describing: id!) + "\t\t\t Total: \t\t" + String(describing: total!) + " €"
                    dailyList.append(str)
                }
                self.totalTicket.text! = String (totalTicket)
                myTableView.reloadData()
                selectedDate.text=SegmentViewController.selectedDate
                SegmentViewController.selectedDate = ""
            }
        }
        
        print(SegmentViewController.selectedDate)
        
        if(SegmentViewController.selectedCategory != 0){
            let result = DBConnection().getTickets(cat: SegmentViewController.selectedCategory)
            if result.isEmpty == true {
                familyTicketsList = []
                noQueryAlert("")
            }else{
                var totalTicket = 0.0
                familyTicketsList = []
                for r in result {
                    let quantity = r["quantity"]
                    let name = r["name"]
                    let total = r["total"]
                    totalTicket += Double(total as? String ?? "0.00")!
                    let str = String(describing: name!) + "\tCant: " + String(describing: quantity!) + "\t\t" + String(describing: total!) + " €"
                    familyTicketsList.append(str)
                }
                self.totalTicket.text! = String (totalTicket)
            }
            myTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        
        switch(mySegmentegControl.selectedSegmentIndex){
        case 0:
            returnValue = dailyList.count
            break
        case 1:
            
            returnValue = memberTicketsList.count
            break
        case 2:
            returnValue = familyTicketsList.count
            break
        default:
            break
        }
        return returnValue
    
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        switch(mySegmentegControl.selectedSegmentIndex){
        case 0:
            myCell.textLabel!.text = dailyList[indexPath.row]
            break
        case 1:
            myCell.textLabel!.text = memberTicketsList[indexPath.row]
            break
        case 2:
            myCell.textLabel!.text = familyTicketsList[indexPath.row]
            break
        default:
            break
        }
        return myCell
    }

    @IBAction func segmentedControlActionChanged(_ sender: Any) {
        
        switch(mySegmentegControl.selectedSegmentIndex){
        case 0:
            
            break
        case 1:
            queryMember()
            break
        case 2:
            
            break
        default:
            break
        }
        myTableView.reloadData()
    }
    
    
    @IBAction func showQueryPopup(_ sender: UIButton) {
        
        switch(mySegmentegControl.selectedSegmentIndex){
        case 0:
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desVC = mainStoryboard.instantiateViewController(withIdentifier: "DatePopupViewController") as! DatePopupViewController
            self.navigationController?.pushViewController(desVC, animated: true)
            break
        case 1:
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desVC = mainStoryboard.instantiateViewController(withIdentifier: "MembersViewController") as! MembersViewController
            self.navigationController?.pushViewController(desVC, animated: true)
            
            break
        case 2:
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desVC = mainStoryboard.instantiateViewController(withIdentifier: "ByFamilyViewController") as! ByFamilyViewController
            self.navigationController?.pushViewController(desVC, animated: true)
            break
        default:
            break
        }
        
    }
    
    func queryMember(){
        totalMembers = 0.00
        let result = DBConnection().getTickets(member: selectedMember)
        result.forEach{ r in
            totalMembers += r["total"] as! Double
            memberTicketsList.append(String(format: "Id:\(r["id"]!) \t Fecha: \(r["date"]!) \t Total: %.2f€", r["total"] as! Double))
        }
        totalTicket.text = String(format: "%.2f", totalMembers)
    }
    //tras la query de DataBase y no obtener resultado, salta este alert
    func noQueryAlert(_ sender: Any) {
        let alert = UIAlertController(title: "No hay tickets para este día", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cerrar ventana", style: .default) { (action) in}
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
