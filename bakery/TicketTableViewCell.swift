//
//  TicketTableViewCell.swift
//  bakery
//
//  Created by Hate on 04/03/2018.
//  Copyright © 2018 Maria Jose Uceda Garcia. All rights reserved.
//

import UIKit

class TicketTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setProduct(_ p:Product){
        let quantity = DataBase.cart.products[p]
        imageProduct.image = p.image
        titleLabel.text = p.name
        quantityLabel.text = String(describing: quantity ?? 0)
        priceLabel.text = String(format: "%.2f€", p.price)
        totalLabel.text = String(format: "%.2f€", p.price*Double(quantity ?? 0))
    }
}
