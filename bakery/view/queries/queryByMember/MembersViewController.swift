//
//  MembersViewController.swift
//  bakery
//
//  Created by Maria Jose Uceda Garcia on 04/03/2018.
//  Copyright © 2018 Maria Jose Uceda Garcia. All rights reserved.
//

import UIKit

class MembersViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return members.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)-> String?{
        return members[row]["login"] as? String ?? ""
    }
    
    
    @IBOutlet weak var titlePicker: UILabel!
    @IBOutlet weak var membersPicker: UIPickerView!
    @IBOutlet weak var okPicker: UIButton!
    var members = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        membersPicker.delegate = self
        membersPicker.dataSource = self
        
        members = DBConnection().getData(table: "member")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveMember(_ sender: UIButton) {
        //vuelve hacia atrás
        navigationController?.popToRootViewController(animated: true)
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
