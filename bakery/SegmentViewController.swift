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
    
    var dailyList:[String] = ["Private 1", "Private 2"] //tuplas de la consulta de tickets por dia
    let memberTicketsList:[String] = ["Priv 1", "Priv 2"] //tuplas de la consulta de tickets por empleado
    var familyTicketsList:[String] = ["aaaa 1", "aaa 2"] //tuplas de la consulta de tickets por familia
    
    public static var selectedDate = ""
    public static var selectedCategory = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        if(!SegmentViewController.selectedDate.isEmpty){
            dailyList = ["Private changed 1", "Private changed 2"]
            myTableView.reloadData()
        }
        print(SegmentViewController.selectedDate)
        
        if(!SegmentViewController.selectedCategory.isEmpty){
            familyTicketsList = ["aaaa 1", "aaa 2"]
            myTableView.reloadData()
        }
        print(SegmentViewController.selectedCategory)
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
            //nada de momento
            break
        case 2:
            //nada de momento
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desVC = mainStoryboard.instantiateViewController(withIdentifier: "ByFamilyViewController") as! ByFamilyViewController
            self.navigationController?.pushViewController(desVC, animated: true)
            break
        default:
            break
        }    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
