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
    
    var categorias: [String] = ["Pan","Croissant","Navidad","Bolleria","Otros"]
    let imgCategorias: [UIImage] = [
        UIImage(named: "bread")!,
        UIImage(named: "croissant")!,
        UIImage(named: "christmas")!,
        UIImage(named: "pastries")!,
        UIImage(named: "other")!,
    ]
    
    let imgProducts: [UIImage] = [
        
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        UIImage(named: "pastries")!,
        
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        collectionView.delegate? = self
        //        collectionView.dataSource? = self
        //        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        getNombreProduct()
    }
    
    // MARK: Delegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        print("celda seleccionada \(DataBase.products[indexPath.item].name)")
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        desVC.image = imgProducts[indexPath.row]
        desVC.name = DataBase.products[indexPath.item].name
        desVC.desc = DataBase.products[indexPath.item].description
        desVC.price = DataBase.products[indexPath.item].price
        self.navigationController?.pushViewController(desVC, animated: true)
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
    
    // Section
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
        //Pinta 4 veces todos los elementos
        return categorias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionView", for: indexPath) as! SectionView
        header.imCategoria.image = imgCategorias[indexPath.section]
        header.lbCategoria.text = categorias[indexPath.section]
        
        return header
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
