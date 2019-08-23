//
//  ViewControllerGestureRecognizer.swift
//  ARSphericalHarmonicsLighting
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
    
    @objc func longPressGestureAction(sender: UILongPressGestureRecognizer) {
        print("long press")
    }
    
    @objc func panPressGestureAction(sender: UIPanGestureRecognizer) {
        print("pan press")
    }
    
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
    
    @objc func rotationGestureAction(sender: UIRotationGestureRecognizer) {
        print("rotation")
    }
    
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
