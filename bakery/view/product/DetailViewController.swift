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
    var price = 0.00
    var id = ""
    var familia = 0
    var pickOption = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]
    
    var categorias = ["Pan","Bolleria","Croissant","Navidad","Otros"]
    
    //AÑADIR PRODUCTO AL TICKET
    @IBAction func onAlertTapped(_ sender: Any) {
         let alert = UIAlertController(title: "Agregado al ticket", message: "", preferredStyle: .alert)
         let action = UIAlertAction(title: "Cerrar ventana", style: .default) { (action) in self.setDicctionaryOfPreviousTicket() }
         alert.addAction(action)
         present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = name
        
        // Do any additional setup after loading the view.
        imgImage.image = image
        lbName.text! = categorias[familia-1]
        lbDescription.text! = desc
        lbPrice.text! = String(format:"%.2f", price)
        
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
    
    func setDicctionaryOfPreviousTicket(){
        //Si existe ya almacenado ese ID Producto en nuestro Diccionario
        //Tan solo tengo que sumar la cantidad guardada, con la nueva cantidad seleccionada
        var product: Product? = nil
        for p in DataBase.products {
            if(p.id == Int(self.id)){
                product = p
            }
        }
        
        if let countExists = DataBase.cart.products[product!]{
            let countExistsInNumber = Int(countExists)
            let newCountInNumber = Int(tfPicker.text!)
            let sumCount = countExistsInNumber + newCountInNumber!
            
            DataBase.cart.products[product!] = sumCount;
        }else{//Sino existe el producto como guardado, tan solo crear el nuevo Id Producto en el diccionario
            DataBase.cart.products[product!] = Int(tfPicker.text!);
        }
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
