//
//  ViewControllerSegue.swift
//  ARSphericalHarmonicsLighting
//
//  This file is an extension of ViewController,
//  which is used to deal with everything related to segues
//  The file is organized as follows:
//  >
//  >> @IBAction func tableViewControllerUnwindToViewController(sender: UIStoryboardSegue)
//  >> @IBAction func collectionViewControllerUnwindToViewController(sender: UIStoryboardSegue)
//  >
//
//  Created by Jing Yang on 8/23/19.
//  Copyright © 2019 Jing Yang. All rights reserved.
//

import ARKit

extension ViewController {
    
    /*
     Description:
     This function is a unwind segue from Table View Controller, which is used to pass debug status back to the current view controller.
     Input:
     @ UIStoryboardSegue sender: a segue sender
     Output:
     @ nil returnValue: nil
     */
    @IBAction func tableViewControllerUnwindToViewController(sender: UIStoryboardSegue) {
        guard let tableViewController = sender.source as? TableViewControllerDebugMenu else { return }
        
        // set showboundingBoxes status
        self.isShowBoundingBoxes = tableViewController.isShowBoundingBoxes
        if tableViewController.isShowBoundingBoxes == true {
            viewScene.debugOptions.insert(SCNDebugOptions.showBoundingBoxes)
        } else {
            viewScene.debugOptions.remove(SCNDebugOptions.showBoundingBoxes)
        }
        
        // set showDetectedPlanes status
        self.isShowDetectedPlanes = tableViewController.isShowDetectedPlanes
        
        // set showFeaturePoints status
        self.isShowFeaturePoints = tableViewController.isShowFeaturePoints
        if tableViewController.isShowFeaturePoints == true {
            viewScene.debugOptions.insert(SCNDebugOptions.showFeaturePoints)
        } else {
            viewScene.debugOptions.remove(SCNDebugOptions.showFeaturePoints)
        }
        
        // set showWorldOrigin status
        self.isShowWorldOrigin = tableViewController.isShowWorldOrigin
        if tableViewController.isShowWorldOrigin == true {
            viewScene.debugOptions.insert(SCNDebugOptions.showWorldOrigin)
        } else {
            viewScene.debugOptions.remove(SCNDebugOptions.showWorldOrigin)
        }
        
        // set showWireframe status
        self.isShowWireframe = tableViewController.isShowWireFrame
        if tableViewController.isShowWireFrame == true {
            viewScene.debugOptions.insert(SCNDebugOptions.showWireframe)
        } else {
            viewScene.debugOptions.remove(SCNDebugOptions.showWireframe)
        }
    }
    
    /*
     Description:
     This function is a unwind segue from Collection View Controller, which is used to pass mesh selection back to the current view controller.
     Input:
     @ UIStoryboardSegue sender: a segue sender
     Output:
     @ nil returnValue: nil
     */
    @IBAction func collectionViewControllerUnwindToViewController(sender: UIStoryboardSegue) {
        
        // perform haptic feedback
        feedbackSelection.selectionChanged()
        
        // set selected mesh
        guard let collectionViewController = sender.source as? CollectionViewControllerMeshMenu else { return }
        
        self.selectedMeshName = collectionViewController.selectedMeshName
    }
}
