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
    
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var title3: UILabel!
    var dailyList:[[String:Any]] = [] //tuplas de la consulta de tickets por dia
    var memberTicketsList:[[String:Any]] = [] //tuplas de la consulta de tickets por empleado
    var familyTicketsList:[[String:Any]] = [] //tuplas de la consulta de tickets por familia
    
    public static var selectedDate: String = "2018/03/06"
    
    public static var selectedCategory: Int = 0
    public static var selectedMember = 3
    
    public static var selectedMemberName = ""
    public static var selectedCategoryName = ""
    
    var totalDate:Double = 0.00
    var totalMember:Double = 0.00
    var totalCategory:Double = 0.00
    
    var typedDate:String {
        get{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let d = formatter.date(from: SegmentViewController.selectedDate)
            formatter.dateFormat = "dd/MM/yyyy"
            let out = formatter.string(from: d!)
            return out
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        switch(mySegmentegControl.selectedSegmentIndex){
            case 0:
                queryDate()
                selectedDate.text = typedDate
                totalTicket.text = String(format: "%.2f", totalDate)
            break
            case 1:
                queryMember()
                selectedDate.text = SegmentViewController.selectedMemberName
                totalTicket.text = String(format: "%.2f", totalMember)
            break
            case 2:
                queryFamily()
                selectedDate.text = SegmentViewController.selectedCategoryName
                totalTicket.text = String(format: "%.2f", totalCategory)
            break
            default:
            break
        }
        
        myTableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        queryDate()
        myTableView.reloadData()
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
            title1.text! = "ID"
            title2.text! = ""
            title3.text! = "SUBTOTAL"
            returnValue = dailyList.count
            break
        case 1:
            title1.text! = "ID"
            title2.text! = "FECHA"
            title3.text! = "SUBTOTAL"
            returnValue = memberTicketsList.count
            break
        case 2:
            title1.text! = "PRODUCTO"
            title2.text! = "CANTIDAD"
            title3.text! = "SUBTOTAL"
            returnValue = familyTicketsList.count
            break
        default:
            break
        }
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! QueriesCell
        
        
        switch(mySegmentegControl.selectedSegmentIndex){
        case 0:
            myCell.setData(type: 0, data: dailyList[indexPath.row])
            break
        case 1:
            myCell.setData(type: 1, data: memberTicketsList[indexPath.row])
            break
        case 2:
            myCell.setData(type: 2, data: familyTicketsList[indexPath.row])
            break
        default:
            break
        }
        return myCell
    }

    @IBAction func segmentedControlActionChanged(_ sender: Any) {
        switch(mySegmentegControl.selectedSegmentIndex){
        case 0:
                selectedDate.text = typedDate
                totalTicket.text = String(format: "%.2f", totalDate)
            break
        case 1:
                selectedDate.text = SegmentViewController.selectedMemberName
                totalTicket.text = String(format: "%.2f", totalMember)
            break
        case 2:
                selectedDate.text = SegmentViewController.selectedCategoryName
                totalTicket.text = String(format: "%.2f", totalCategory)
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
    
    func queryDate(){
        totalDate = 0.00
        let result = DBConnection().getTickets(date: SegmentViewController.selectedDate)
        if result.isEmpty == true {
            dailyList = []
            noQueryAlert("", msg: "No se encontraron tickets en esta fecha") //llama cuando no hay consulta
        }else{
            
            dailyList = result
            for r in result {
                let total = r["total"]
                totalDate += total as! Double
            }
            myTableView.reloadData()
            selectedDate.text = SegmentViewController.selectedDate
        }
    }
    
    func queryMember(){
        totalMember = 0.00
        let result = DBConnection().getTickets(member: SegmentViewController.selectedMember)
        memberTicketsList = result
        result.forEach{ r in
            totalMember += r["total"] as! Double
        }
        if result.isEmpty {noQueryAlert("", msg: "No se encontraron tickets de este empleado")}
    }
    
    func queryFamily(){
        totalCategory = 0.00
        let result = DBConnection().getTickets(cat: SegmentViewController.selectedCategory)
        familyTicketsList = result
        if result.isEmpty == true {
            familyTicketsList = []
            noQueryAlert("", msg: "No se encontraron tickets de esta familia")
        }else{
            for r in result {
                let total = r["total"]
                totalCategory += Double(total as? String ?? "0.00")!
            }
        }
        selectedDate.text = SegmentViewController.selectedCategoryName
    }
    
    //tras la query de DataBase y no obtener resultado, salta este alert
    func noQueryAlert(_ sender: Any, msg:String) {
        let alert = UIAlertController(title: msg, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cerrar ventana", style: .default) { (action) in}
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
