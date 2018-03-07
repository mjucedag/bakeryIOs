//
//  TicketTableViewCell.swift
//  bakery
//
//  Created by Hate on 04/03/2018.
//  Copyright © 2018 Maria Jose Uceda Garcia. All rights reserved.
//

import UIKit

class TicketTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var viewRow: UIView!
    
    let pickOption = [Int](1...20)
    var p:Product? = nil
    var pickerView = UIPickerView()
    var table:TicketTableViewController = TicketTableViewController()
    override func awakeFromNib() {
        super.awakeFromNib()
        pickerView.delegate = self
        quantityLabel.inputView = pickerView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setProduct(_ p:Product, _ t: TicketTableViewController){
        let quantity = DataBase.cart.products[p]
        self.table = t
        self.p = p
        imageProduct.image = p.image
        titleLabel.text = p.name
        quantityLabel.text = String(describing: quantity ?? 0)
        priceLabel.text = String(format: "%.2f€", p.price)
        totalLabel.text = String(format: "%.2f€", p.price*Double(quantity ?? 0))
        pickerView.selectRow(quantity!-1, inComponent: 0, animated: false)
    }
    
    public func drawShadow(){
        let layer = viewRow.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //establece el número de filas de componentes
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    //titulo definido para cada fila
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(describing: pickOption[row])
    }
    //actualiza el campo de texto cuando se selecciona la fila
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        quantityLabel.text = String(describing: pickOption[row])
        DataBase.cart.products[p!] = pickOption[row]
        table.refresh()
        quantityLabel.endEditing(true)
    }
}
