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
        return members[row]["login"] as? String ?? "No name"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = row
    }
    
    @IBOutlet weak var titlePicker: UILabel!
    @IBOutlet weak var membersPicker: UIPickerView!
    @IBOutlet weak var okPicker: UIButton!
    var members = [[String:Any]]()
    var selected = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        membersPicker.delegate = self
        membersPicker.dataSource = self
        
        members = DBConnection().getData(table: "member")
    }

    @IBAction func saveMember(_ sender: UIButton) {
        //vuelve hacia atrás
        SegmentViewController.selectedMember = Int(members[selected]["id"] as? String ?? "0")!
        SegmentViewController.selectedMemberName = members[selected]["login"] as? String ?? ""
        navigationController?.popToRootViewController(animated: true)
    }
}
