//
//  CollectionViewController.swift
//  bakery
//
//  Created by Fran on 28/2/18.
//  Copyright © 2018 Maria Jose Uceda Garcia. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var productos:[Product] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destino = segue.destination as? LoginViewController{
            destino.products = productos
        }
        
    }
    let products = ["1", "2", "3", "4", "5", "6"]
    
    let imgElementos: [UIImage] = [
        
        UIImage(named: "pastries")!,
        UIImage(named: "christmas")!,
        UIImage(named: "croissant")!,
        UIImage(named: "bread")!,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate? = self
        collectionView.dataSource? = self
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: Delegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
    }
    
    // MARK: DataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return products.count
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! CollectionViewCell
        
        for producto in productos {
            cell.lProduct.text = producto.name
            cell.ivProduct.image = imgElementos[indexPath.item]
        }
        print("numero de productos: \(productos.count)")
        
        return cell
    }
//    //Para las secciones
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
