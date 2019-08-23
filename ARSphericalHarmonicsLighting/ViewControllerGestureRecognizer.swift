//
//  ViewControllerGestureRecognizer.swift
//  ARSphericalHarmonicsLighting
//
//  This file is an extension of ViewController,
//  which is used to deal with everything related to gesture recognizer,
//  including gesture recognizer registration, gesture action and so on.
//  The file is organized as follows:
//  >
//  >> func registerGestureRecognizers()
//  >> @objc func longPressGestureAction(sender: UILongPressGestureRecognizer)
//  >> @objc func panPressGestureAction(sender: UIPanGestureRecognizer)
//  >> @objc func pinchGestureAction(sender: UIPinchGestureRecognizer)
//  >> @objc func rotationGestureAction(sender: UIRotationGestureRecognizer)
//  >> @objc func tapGestureAction(sender: UITapGestureRecognizer)
//  >
//
//  Created by Jing Yang on 8/22/19.
//  Copyright © 2019 Jing Yang. All rights reserved.
//

import ARKit
import UIKit

extension ViewController {
    
    /*
     Description:
     This function is used to register gesture recognizers, which are used to detect user interaction
     Input:
     @ nil parameter: nil
     Output:
     @ nil returnValue: nil
    */
    func registerGestureRecognizers() {
        
        // register long press gesture recognizer
        let longPressGestureRecognizer = UILongPressGestureRecognizer()
        longPressGestureRecognizer.addTarget(self, action: #selector(longPressGestureAction))
        self.viewScene.addGestureRecognizer(longPressGestureRecognizer)
        
        // register pan press gesture recognizer
        let panPressGestureRecognizer = UIPanGestureRecognizer()
        panPressGestureRecognizer.addTarget(self, action: #selector(panPressGestureAction))
        self.viewScene.addGestureRecognizer(panPressGestureRecognizer)
        
        // register pinch gesture recognizer
        let pinchGestureRecognizer = UIPinchGestureRecognizer()
        pinchGestureRecognizer.addTarget(self, action: #selector(pinchGestureAction))
        self.viewScene.addGestureRecognizer(pinchGestureRecognizer)
        
        // register rotation gesture recognizer
        let rotationGestureRecognizer = UIRotationGestureRecognizer()
        rotationGestureRecognizer.addTarget(self, action: #selector(rotationGestureAction))
        self.viewScene.addGestureRecognizer(rotationGestureRecognizer)
        
        // register tap gesture recognizer
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: #selector(tapGestureAction))
        self.viewScene.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    /*
     Description:
     This function is used to deal with long press gesture, which is used to remove any object from the current scnee
     Input:
     @ UILongPressGestureRecognizer: a long press gesture recognizer
     Output:
     @ nil returnValue: nil
    */
    @objc func longPressGestureAction(sender: UILongPressGestureRecognizer) {
        print("long press")
    }
    
    /*
     Description:
     This function is used to deal with pan press gesture
     Input:
     @ UIPanGestureRecognizer: a pan press gesture recognizer
     Output:
     @ nil returnValue: nil
    */
    @objc func panPressGestureAction(sender: UIPanGestureRecognizer) {
        print("pan press")
    }
    
    /*
     Description:
     This function is used to deal with pinch gesture, which is used to scale any object in the screen
     Input:
     @ UIPinchGestureRecognizer: a pinch gesture recognizer
     Output:
     @ nil returnValue: nil
    */
    @objc func pinchGestureAction(sender: UIPinchGestureRecognizer) {
        guard let viewScene = sender.view as? ARSCNView else { return }
        let pinchLocation = sender.location(in: viewScene)
        
        let objectHitTest = viewScene.hitTest(pinchLocation)
        if !objectHitTest.isEmpty {
            let pinchAction = SCNAction.scale(by: sender.scale, duration: 0)
            objectHitTest.first?.node.runAction(pinchAction)
            sender.scale = 1.0
        }
    }
    
    /*
     Description:
     This function is used to deal with rotation gesture, which is used to rotate any object in the scene
     Input:
     @ UIRotationGestureRecognizer: a rotation gesture recognizer
     Output:
     @ nil returnValue: nil
    */
    @objc func rotationGestureAction(sender: UIRotationGestureRecognizer) {
        print("rotation")
    }
    
    /*
     Description:
     This function is used to deal with tap gesture, which is used to place a selected object on any detected plane in the scene
     Input:
     @ UITapGesturerecognizer: a tap gesture recognizer
     Output:
     @ nil returnValue: nil
    */
    @objc func tapGestureAction(sender: UITapGestureRecognizer) {
        guard let viewScene = sender.view as? ARSCNView else { return }
        let touchLocation = sender.location(in: viewScene)
        
        let planeHitTest = viewScene.hitTest(touchLocation, types: [.existingPlaneUsingExtent])
        if !planeHitTest.isEmpty {
            let scene = SCNScene(named: "art.scnassets/\(selectedMesh).scn")
            let node = (scene?.rootNode.childNode(withName: selectedMesh, recursively: false))!
            let position = planeHitTest.first?.worldTransform.columns.3
            node.position = SCNVector3(position!.x, position!.y, position!.z)
            self.viewScene.scene.rootNode.addChildNode(node)
        }
        
    }
}
