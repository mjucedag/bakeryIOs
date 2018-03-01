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
    
    var arrayProd:[Product] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destino = segue.destination as? LoginViewController{
            destino.products = arrayProd
        }
        
    }
    
    let imgProducts: [UIImage] = [
        
        UIImage(named: "pastries")!,
        UIImage(named: "christmas")!,
        UIImage(named: "croissant")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "pastries")!,
        UIImage(named: "christmas")!,
        UIImage(named: "croissant")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "pastries")!,
        UIImage(named: "christmas")!,
        UIImage(named: "croissant")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "pastries")!,
        UIImage(named: "christmas")!,
        UIImage(named: "croissant")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "bread")!,
        UIImage(named: "pastries")!,
        UIImage(named: "christmas")!,
        UIImage(named: "croissant")!,
        UIImage(named: "pastries")!,
        UIImage(named: "christmas")!,
        UIImage(named: "croissant")!,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate? = self
        collectionView.dataSource? = self
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: Delegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
//        print("celda seleccionada \(indexPath.row)")
    }
    
    // MARK: DataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        print("num de productos \(arrayProd.count)")
        return arrayProd.count
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! CollectionViewCell

        cell.ivProduct.image = imgProducts[indexPath.item]
//        cell.lProduct.text = arrayProd[indexPath.item]
        
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
