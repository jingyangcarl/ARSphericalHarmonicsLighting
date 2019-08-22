//
//  ViewControllerButtons.swift
//  ARSphericalHarmonicsLighting
//
//  Created by Jing Yang on 8/21/19.
//  Copyright © 2019 Jing Yang. All rights reserved.
//

import UIKit

extension ViewController {
    
    /*
     Description:
     This function is used to initialize button status including alpha value, text value, and etc.
     Input:
     @ nil parameter: nil
     Output:
     @ nil returnValue: nil
    */
    func buttonInit() {
        self.buttonDebug.showsTouchWhenHighlighted = true
        self.buttonReset.showsTouchWhenHighlighted = true
        self.buttonMesh.showsTouchWhenHighlighted = true
    }
    
    /*
     Description:
     This function is a callback function of button Debug, which will pop up or hide the debug option menu
     Input:
     @ Any _ sender: any sender
     Output:
     @ nil returnValue: nil
    */
    @IBAction func buttonDebug(_ sender: Any) {
        // perform haptic feedback
        feedbackSelection.selectionChanged()
        
        // pop up or hide the menu
        if isDebugMenuShowed == true {
            // change isButtonDebugPushed status
            isDebugMenuShowed = !isDebugMenuShowed
            
            // set button alpha value
            buttonDebug.alpha = 1.0
            
            // hide debug option menu with animation
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                options: .curveEaseOut,
                animations: {self.viewDebug.alpha = 0.0},
                completion: {(_) in self.viewDebug.isHidden = !self.viewDebug.isHidden}
            )
        } else {
            // change isButtonDebugPushed status
            isDebugMenuShowed = !isDebugMenuShowed
            
            // set button alpha value
            buttonDebug.alpha = 0.4
            
            // show debug option menu with animation
            viewDebug.isHidden = !viewDebug.isHidden
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                options: .curveEaseIn,
                animations: {self.viewDebug.alpha = 0.7},
                completion: {(_) in}
            )
        }
    }
    
    /*
     Description:
     This function is a callback function of button Reset, which will reset the AR world tracking settings, existing anchors, and etc.
     Input:
     @ Any _ sender: any sender
     Output:
     @ nil returnValue: nil
    */
    @IBAction func buttonReset(_ sender: Any) {
        
    }
    
    /*
     Description:
     This function is a callback function of button Mesh, which will pop up or hide the mesh option menu
     Input:
     @ Any _ sender: any sender
     Output:
     @ nil returnValue: nil
    */
    @IBAction func buttonMesh(_ sender: Any) {
        // perform haptic feedback
        feedbackSelection.selectionChanged()
        
        // pop up or hide the menu
        if isMeshMenuShowed == true {
            // change isButtonDebugPushed status
            isMeshMenuShowed = !isMeshMenuShowed
            
            // set button alpha value
            buttonMesh.alpha = 1.0
            
            // hide debug option menu with animation
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                options: .curveEaseOut,
                animations: {self.viewMesh.alpha = 0.0},
                completion: {(_) in self.viewMesh.isHidden = !self.viewMesh.isHidden}
            )
        } else {
            // change isButtonDebugPushed status
            isMeshMenuShowed = !isMeshMenuShowed
            
            // set button alpha value
            buttonMesh.alpha = 0.4
            
            // show debug option menu with animation
            viewMesh.isHidden = !viewMesh.isHidden
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                options: .curveEaseIn,
                animations: {self.viewMesh.alpha = 0.7},
                completion: {(_) in}
            )
        }
    }
}
