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
    
    var nameCategory: [String] = ["bread","croissant","christmas","pastries","other"]
    var imgCategorias: [UIImage] = [
        UIImage(named: "bread")!,
        UIImage(named: "croissant")!,
        UIImage(named: "christmas")!,
        UIImage(named: "pastries")!,
        UIImage(named: "other")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Delegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let name = nameCategory[indexPath.row]
        SegmentViewController.selectedCategory = name
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
