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
    var nombresFiltrados = [String]()
    var imgFiltradas = [UIImage]()
    
    var productName = [String]()
    func getNombreProduct(){
        for producto in DataBase.products{
            productName.append(producto.name)
        }
    }
    var imgProducts: [UIImage] = [UIImage]()
    private func getImageProduct(){
        for producto in DataBase.products{
            imgProducts.append(producto.image)
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
        print("celda seleccionada \(DataBase.products[indexPath.item].name)")
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        desVC.image = DataBase.products[indexPath.item].image
        desVC.name = DataBase.products[indexPath.item].name
        desVC.familia = DataBase.products[indexPath.item].idFamily
        desVC.desc = DataBase.products[indexPath.item].description
        desVC.price = String(DataBase.products[indexPath.item].price)
        self.navigationController?.pushViewController(desVC, animated: true)
    }
    
    // MARK: DataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if buscando {
            return nombresFiltrados.count
        }
        return DataBase.products.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! CollectionViewCell

        let textoLabel : String!
        let image: UIImage!
        
        if buscando {
            textoLabel = nombresFiltrados[indexPath.row]
//            image = imgFiltradas[indexPath.row]
            image = nil //Al filtrar no muestra ninguna imagen
        }else{
            textoLabel = productName[indexPath.row]
            image = imgProducts[indexPath.row]
        }
        
        cell.ivProduct.image = image
        cell.lbProduct.text = textoLabel
        
        return cell
    }
    
    // Section
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        //Pinta 4 veces todos los elementos
//        return categorias.count
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
            nombresFiltrados = productName.filter({$0.lowercased().contains(searchText.lowercased())})
            //llenar imgFiltradas, para que se muestren al buscar
            collectionView.reloadData()
        }
    }
}
