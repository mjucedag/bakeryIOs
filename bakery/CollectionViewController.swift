//
//  CollectionViewController.swift
//  bakery
//
//  Created by Fran on 28/2/18.
//  Copyright © 2018 Maria Jose Uceda Garcia. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var buscando = false
    var filterData = [String]()
    
    var productName = [String]()
    private func getNombreProduct(){
        for producto in DataBase.products{
            productName.append(producto.name)
        }
    }
    private func getImageProduct(){
        for producto in DataBase.products{
            imgProducts.append(producto.image)
        }
    }
    
    var imgProducts: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        collectionView.delegate? = self
        //        collectionView.dataSource? = self
        //        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        getNombreProduct()
        getImageProduct()
        
    }
    
    // MARK: Delegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
    }
    
    // MARK: DataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if buscando {
            return filterData.count
        }
        return DataBase.products.count
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! CollectionViewCell
        
        let textoLabel : String!
        
        if buscando {
            textoLabel = filterData[indexPath.row]
        }else{
            textoLabel = productName[indexPath.item]
        }
        cell.ivProduct.image = imgProducts[indexPath.item]
        cell.lbProduct.text = textoLabel
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            buscando = false
            view.endEditing(true)
            collectionView.reloadData()
        }else{
            buscando = true
            filterData = productName.filter({$0 == searchBar.text})
            collectionView.reloadData()
        }
    }
    
}
