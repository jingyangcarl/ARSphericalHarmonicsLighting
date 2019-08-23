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

    struct meshCell {
        var name: String?
        var image: UIImage?
        init(name: String?, image: UIImage?) {
            self.name = name
            self.image = image
        }
    }
    
    // the icon here is generated using screenshot (400 * 400)
    let meshOptions: [meshCell] = [
        meshCell(name: "MeshCapsule", image: #imageLiteral(resourceName: "MeshCapsule.png")),
        meshCell(name: "MeshCone", image: #imageLiteral(resourceName: "MeshCone.png")),
        meshCell(name: "MeshCube", image: #imageLiteral(resourceName: "MeshCube.png")),
        meshCell(name: "MeshCylinder", image: #imageLiteral(resourceName: "MeshCylinder.png")),
        meshCell(name: "MeshGeosphere", image: #imageLiteral(resourceName: "MeshGeosphere.png")),
        meshCell(name: "MeshPyramid", image: #imageLiteral(resourceName: "MeshPyramid.png")),
        meshCell(name: "MeshSphere", image: #imageLiteral(resourceName: "MeshSphere.png")),
        meshCell(name: "MeshTorus", image: #imageLiteral(resourceName: "MeshTorus.png")),
        meshCell(name: "MeshTube", image: #imageLiteral(resourceName: "MeshTube.png")),
        meshCell(name: "MeshShip", image: #imageLiteral(resourceName: "MeshShip.png")),
    ]
    
    // current mesh
    var selectedMesh: String!
    
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

    /*
     Description:
     This function is an override function, which is used to configure every cells
     Input:
     @ UICollectionView _ collectionView: the collection view
     @ IndexPath cellForItemAt indexPath: the indexpath to the cell
     Output:
     @ UICollectionViewCell returnValue: the configured cell
    */
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCellMeshMenu
        
        // Configure the cell
        cell.backgroundColor = UIColor.clear
        cell.imageView.image = meshOptions[indexPath.row].image
        cell.name = meshOptions[indexPath.row].name
        
        return cell
    }
    
    /*
     Description:
     This function is an override function, which will be triggered everytime a cell is about to be displayed (the action like scroll up/down may trigger the function). Since the UIkit cannot access off-screen cells, this function is used to do update.
     Input:
     @ UICollectionView _ collectionView: the collection view
     @ UICollectionViewCel willDisplay cell: the cell to be displayed
     @ IndexPath forItemAt indexPath: the indexpath to the cell
    */
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if cell.isSelected == true {
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.white.cgColor
        } else {
            cell.layer.borderWidth = 0.0
            cell.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    /*
     Description:
     This function is an override function, which will be triggered everytime a cell is selected. The function here is used to visualize the selection with a setting on cell border
     Input:
     @ UICollectionView _ collectionView: the collectionv view
     @ IndexPath didSelectItemAt indexPath: the indexpath to the selected cell
     Output:
     @ nil returnValue: nil
    */
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // show selection box
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCellMeshMenu
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.white.cgColor
        cell.isSelected = true
        
        // update selected item
        selectedMesh = cell.name
        
        // perform segue
        performSegue(withIdentifier: "collectionViewControllerUnwindToViewController", sender: self)
    }
    
    /*
     Description:
     This function is an override function, which will be triggered everytime a cell is deselected. The function here is used to visualize the deselection with a setting on cell border. Moreover, the deselected cell is a off-screen cell, the cell cannot be accessed using collectionView with off-screen cell's indexpath.
     Input:
     @ UICollectionView _ collectionView: the collectionv view
     @ IndexPath didDeselectItemAt indexPath: the indexpath to the deselected cell
     Output:
     @ nil returnValue: nil
    */
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // hide selection box
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0.0
        cell?.layer.borderColor = UIColor.clear.cgColor
        cell?.isSelected = false
    }
    
    
    /*
     Description:
     This function is used to prepare data before the segue, where the segue is pointing to the main view controller
     Input:
     @ UIStoryboardSegue for seque: a segue
     @ Any? sender: any sender
     Output:
     @ nil returnValue: nil
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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
    
}
