//
//  CollectionViewController.swift
//  bakery
//
//  Created by Fran on 28/2/18.
//  Copyright © 2018 Maria Jose Uceda Garcia. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
//    var idFamilia: [Int] = [Int]()
//    var prodFamily: Int = -1
    
    var arrayPan: [Product] = [Product]()
    var arrayBolleria: [Product] = [Product]()
    var arrayCroissant: [Product] = [Product]()
    var arrayNavidad: [Product] = [Product]()
    var arrayOtros: [Product] = [Product]()
    
    //
    var productos: [[Product]] = []
    var sections: [String] = [String]()
    var seleccionPanArray: [Int] = [Int]()
    var seleccionBolleriaArray: [Int] = [Int]()
    var seleccionCroissantArray: [Int] = [Int]()
    var seleccionNavidadArray: [Int] = [Int]()
    var seleccionOtroArray: [Int] = [Int]()
    //
    
    func filtraProd(){
        for producto in DataBase.products{
            switch producto.idFamily {
                case 1:
                    arrayPan.append(producto)
                    break
                case 2:
                    arrayBolleria.append(producto)
                    break
                case 3:
                    arrayCroissant.append(producto)
                    break
                case 4:
                    arrayNavidad.append(producto)
                    break
                case 5:
                    arrayOtros.append(producto)
                    break
                default:
                    break
            }

        }
    }
    
    var resultadoFam = DBConnection().getData(table: "family")
    func getFamily(){
        resultadoFam.sort{return Int($0["id"] as? String ?? "0")! < Int($1["id"] as? String ?? "0")! }
        for fam in resultadoFam{
            sections.append(fam["family"] as? String ?? "")
//            idFamilia.append(Int(fam["id"] as? String ?? "0")!)
            print("familia: \(fam["family"])")
        }
        print("familias: \(sections)")
    }
    
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
    
//    var categorias: [String] = ["Pan","Croissant","Navidad","Bolleria","Otros"]
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
//        getNombreProduct()
//        getImageProduct()
        
        //
        getFamily()
        filtraProd()
        //////
        productos.append(arrayPan)
        productos.append(arrayBolleria)
        productos.append(arrayCroissant)
        productos.append(arrayNavidad)
        productos.append(arrayOtros)
        /**************/
        seleccionPanArray = Array(repeating: 0, count: productos[0].count)
        seleccionBolleriaArray = Array(repeating: 0, count: productos[1].count)
        seleccionCroissantArray = Array(repeating: 0, count: productos[2].count)
        seleccionNavidadArray = Array(repeating: 0, count: productos[3].count)
        seleccionOtroArray = Array(repeating: 0, count: productos[4].count)
        //////
        
    }
    
    // MARK: Delegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
//        print("celda seleccionada \(DataBase.products[indexPath.item].name)")
//        prodFamily = DataBase.products[indexPath.item].idFamily
//        print("producto de la familia: \(prodFamily)")
        
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let productoToDetail = productos[indexPath[0]][indexPath[1]]
        desVC.image = productoToDetail.image
        desVC.name = productoToDetail.name
        desVC.familia = productoToDetail.idFamily
        desVC.desc = productoToDetail.description
        desVC.price = productoToDetail.price
        desVC.id = String(productoToDetail.id)
        self.navigationController?.pushViewController(desVC, animated: true)
    }
    
    // MARK: DataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if buscando {
            return nombresFiltrados.count
        }
        return productos[section].count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! CollectionViewCell

        let section = indexPath.section
        let row = indexPath.row
        let producto = productos[section][row]
        
        cell.lbProduct.text = producto.name
        
//        cell.lbPrecio.text = producto.price
        
        var textoLabel : String! = ""
        let image: UIImage!

        if buscando {
            textoLabel = nombresFiltrados[indexPath.row]
//            image = imgFiltradas[indexPath.row]
            image = nil //Al filtrar no muestra ninguna imagen
        }else{
            textoLabel = producto.name
            image = producto.image
        }

        cell.ivProduct.image = image
        cell.lbProduct.text = textoLabel
        
        return cell
    }
    
    // Section
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return productos.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionView", for: indexPath) as! SectionView
        header.imCategoria.image = imgCategorias[indexPath.section]
        header.lbCategoria.text = sections[indexPath.section]
        
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
