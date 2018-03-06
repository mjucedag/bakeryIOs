//
//  QueriesCell.swift
//  bakery
//
//  Created by dam on 6/3/18.
//  Copyright © 2018 Maria Jose Uceda Garcia. All rights reserved.
//

import UIKit

class QueriesCell: UITableViewCell {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func setData(type: Int, data: [String:Any]){
        switch(type){
            case 0:
                label1.text! = data["id"] as? String ?? "0"
                label2.text! = ""
                label3.text! = String(format: "%.2f€", Double(data["total"] as? String ?? "0.00")!)
                break
            case 1:
                label1.text! = data["id"] as? String ?? "0"
                label2.text! = data["date"] as? String ?? "0"
                label3.text! = String(format: "%.2f€", Double(data["total"] as? String ?? "0.00")!)
                break
            case 2:
                label1.text! = data["name"] as? String ?? "0"
                label2.text! = data["quantity"] as? String ?? "0"
                label3.text! = String(format: "%.2f€", Double(data["total"] as? String ?? "0.00")!)
                break
            default:
                break
        }
    }

}
