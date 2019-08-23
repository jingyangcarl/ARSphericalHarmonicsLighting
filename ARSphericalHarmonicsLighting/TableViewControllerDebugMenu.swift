//
//  TableViewControllerDebugMenu.swift
//  ARSphericalHarmonicsLighting
//
//  Created by Jing Yang on 8/21/19.
//  Copyright © 2019 Jing Yang. All rights reserved.
//

import UIKit

class TableViewControllerDebugMenu: UITableViewController {
    
    @IBOutlet var tableViewDebug: UITableView!
    
    @IBOutlet weak var switchShowBoundingBoxes: UISwitch!
    @IBOutlet weak var switchShowDetectedPlanes: UISwitch!
    @IBOutlet weak var switchShowFeaturePoints: UISwitch!
    @IBOutlet weak var switchShowWorldOrigin: UISwitch!
    @IBOutlet weak var switchShowWireframe: UISwitch!
    
    // Debug options
    var isShowBoundingBoxes: Bool?
    var isShowDetectedPlanes: Bool?
    var isShowFeaturePoints: Bool?
    var isShowWorldOrigin: Bool?
    var isShowWireFrame: Bool?
    
    let debugOptions: [String] = [
        "showBoundingBoxes",
        "showDetectedPlanes",
        "showFeaturePoints",
        "showWorldOrigin",
        "showWireframe"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Set default color
        tableViewDebug.backgroundColor = UIColor.black
        tableViewDebug.allowsSelection = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return debugOptions.count
    }
    
    @IBAction func switchShowBoundingBoxes(_ sender: Any) {
        isShowBoundingBoxes = switchShowBoundingBoxes.isOn
        performSegue(withIdentifier: "tableViewControllerUnwindToViewController", sender: self)
    }
    
    @IBAction func switchShowDetectedPlanes(_ sender: Any) {
        isShowDetectedPlanes = switchShowDetectedPlanes.isOn
        performSegue(withIdentifier: "tableViewControllerUnwindToViewController", sender: self)
        
    }
    @IBAction func switchShowFeaturePoints(_ sender: Any) {
        isShowFeaturePoints = switchShowFeaturePoints.isOn
        performSegue(withIdentifier: "tableViewControllerUnwindToViewController", sender: self)
    }
    
    @IBAction func switchShowWorldOrigin(_ sender: Any) {
        isShowWorldOrigin = switchShowWorldOrigin.isOn
        performSegue(withIdentifier: "tableViewControllerUnwindToViewController", sender: self)
    }
    
    @IBAction func switchShowWireFrame(_ sender: Any) {
        isShowWireFrame = switchShowWireframe.isOn
        performSegue(withIdentifier: "tableViewControllerUnwindToViewController", sender: self)
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


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
