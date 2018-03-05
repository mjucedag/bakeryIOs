//
//  ByFamilyViewController.swift
//  bakery
//
//  Created by Fran on 4/3/18.
//  Copyright © 2018 Maria Jose Uceda Garcia. All rights reserved.
//

import UIKit

class ByFamilyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var idCategorias: [Int] = [Int]()
    
    var resultadoFam = DBConnection().getData(table: "family")
    func getFamily(){
        resultadoFam.sort{return Int($0["id"] as? String ?? "0")! < Int($1["id"] as? String ?? "0")! }
        for fam in resultadoFam{
            idCategorias.append(Int(fam["id"] as? String ?? "0")!)
        }
    }
    
    var imgCategorias: [UIImage] = [
        UIImage(named: "bread")!,
        UIImage(named: "pastries")!,
        UIImage(named: "croissant")!,
        UIImage(named: "christmas")!,
        UIImage(named: "other")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFamily()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Delegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let id = idCategorias[indexPath.row]
        SegmentViewController.selectedCategory = id
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: DataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return imgCategorias.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.ivCategory.image = imgCategorias[indexPath.row]
        
        return cell
    }
    
}
