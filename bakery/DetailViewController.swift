//
//  DetailViewController.swift
//  bakery
//
//  Created by Maria Jose Uceda Garcia on 02/03/2018.
//  Copyright © 2018 Maria Jose Uceda Garcia. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var tfPicker: UITextField!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    
    var image = UIImage()
    var name = ""
    var desc = ""
    var price = ""
    var pickOption = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        imgImage.image = image
        lbName.text! = name
        lbDescription.text! = desc
        lbPrice.text! = price
        
        //hace el picker de cantidad
        let pickerView = UIPickerView()
        pickerView.delegate = self
        tfPicker.inputView = pickerView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -   PICKER  Cantidad
    //establece el número de componentes en vista selector
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //establece el número de filas de componentes
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    //titulo definido para cada fila
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    //actualiza el campo de texto cuando se selecciona la fila
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tfPicker.text = pickOption[row]
        tfPicker.endEditing(true)
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

