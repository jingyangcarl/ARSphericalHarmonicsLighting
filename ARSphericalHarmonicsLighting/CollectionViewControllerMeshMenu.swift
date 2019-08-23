//
//  CollectionViewControllerMeshMenu.swift
//  ARSphericalHarmonicsLighting
//
//  Created by Jing Yang on 8/21/19.
//  Copyright © 2019 Jing Yang. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MeshMenuCell"

class CollectionViewControllerMeshMenu: UICollectionViewController {
    
    @IBOutlet var collectionViewMesh: UICollectionView!

    
    // the icon here is generated using screenshot (400 * 400)
    let meshOptions: [UIImage] = [
        #imageLiteral(resourceName: "MeshCapsule.png"), #imageLiteral(resourceName: "MeshCone.png"), #imageLiteral(resourceName: "MeshCube.png"), #imageLiteral(resourceName: "MeshCylinder.png"), #imageLiteral(resourceName: "MeshGeosphere.png"), #imageLiteral(resourceName: "MeshPyramid.png"), #imageLiteral(resourceName: "MeshSphere.png"), #imageLiteral(resourceName: "MeshTorus.png"), #imageLiteral(resourceName: "MeshTube.png"), #imageLiteral(resourceName: "MeshShip.png")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        collectionViewMesh.backgroundColor = UIColor.black
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return meshOptions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCellMeshMenu
        
        // Configure the cell
        cell.backgroundColor = UIColor.clear
        cell.imageView.image = meshOptions[indexPath.row]
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath)
        print(cell)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */
    

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // deselect the previous selected cell
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 1.0
        cell?.layer.borderColor = UIColor.white.cgColor
        
        // save location for deselection
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(indexPath)
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0.0
    }
    
}
