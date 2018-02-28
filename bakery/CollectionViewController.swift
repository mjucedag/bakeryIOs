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
        return productos.count
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! CollectionViewCell
        
        for product in productos {
            cell.lProduct.text = product.name
            cell.ivProduct.image = imgElementos[indexPath.item]
        }
        print("numero de productos: \(productos.count)")
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
