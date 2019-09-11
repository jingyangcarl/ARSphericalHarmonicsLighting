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

extension ViewController: UIGestureRecognizerDelegate {
    
    /*
     Description:
     This function is used to register gesture recognizers, which are used to detect user interaction
     Input:
     @ nil parameter: nil
     Output:
     @ nil returnValue: nil
    */
    func registerGestureRecognizers() {
        
        // remember to set ARSCNView in the Main.storyboard as VirtualARSCNView, or the gesture recognier cannot be triggered
        
        // register long press gesture recognizer
        let longPressGestureRecognizer = UILongPressGestureRecognizer()
        longPressGestureRecognizer.minimumPressDuration = 1.5
        longPressGestureRecognizer.addTarget(self, action: #selector(didLongPress))
        longPressGestureRecognizer.delegate = self
        self.viewScene.addGestureRecognizer(longPressGestureRecognizer)
        
        // register pan press gesture recognizer
        let panPressGestureRecognizer = UIPanGestureRecognizer()
        panPressGestureRecognizer.delegate = self
        panPressGestureRecognizer.addTarget(self, action: #selector(didPanPress))
        self.viewScene.addGestureRecognizer(panPressGestureRecognizer)
        
        // register pinch gesture recognizer
        let pinchGestureRecognizer = UIPinchGestureRecognizer()
        pinchGestureRecognizer.delegate = self
        pinchGestureRecognizer.addTarget(self, action: #selector(didPinch))
        self.viewScene.addGestureRecognizer(pinchGestureRecognizer)
        
        // register rotation gesture recognizer
        let rotationGestureRecognizer = UIRotationGestureRecognizer()
        rotationGestureRecognizer.delegate = self
        rotationGestureRecognizer.addTarget(self, action: #selector(didRotation))
        self.viewScene.addGestureRecognizer(rotationGestureRecognizer)
        
        // register tap gesture recognizer
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.delegate = self
        tapGestureRecognizer.addTarget(self, action: #selector(didTap))
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
    @objc func didLongPress(sender: UILongPressGestureRecognizer) {
        
        guard let viewScene = sender.view as? VirtualARSCNView else { return }
        let longPressLocation = sender.location(in: viewScene)
        
        if sender.state == .began {
            selectedMeshNode = viewScene.getSCNNode(at: longPressLocation)!
            if selectedMeshNode.name == "planeNodeParent" {
                selectedMeshNode = SCNNode()
            }
            selectedMeshNode.removeFromParentNode()
        } else if sender.state == .changed {
            
        } else if sender.state == .ended {
            
        }
        
    }
    
    /*
     Description:
     This function is used to deal with pan press gesture
     Input:
     @ UIPanGestureRecognizer: a pan press gesture recognizer
     Output:
     @ nil returnValue: nil
    */
    @objc func didPanPress(sender: UIPanGestureRecognizer) {
        
        guard let viewScene = sender.view as? VirtualARSCNView else { return }
        let panPressLocation = sender.location(in: viewScene)
        
        if sender.state == .began {
            // locate the object using a hit test
            selectedMeshNode = viewScene.getSCNNode(at: panPressLocation)!
            if selectedMeshNode.name == "planeNodeParent"{
                selectedMeshNode = SCNNode()
            }
        } else if sender.state == .changed {
            if let position = viewScene.getPlaneCoordination(at: panPressLocation) {
                selectedMeshNode.worldPosition = position
            } else {
                
            }
        } else if sender.state == .ended {
            
        }
    }
    
    /*
     Description:
     This function is used to deal with pinch gesture, which is used to scale any object in the screen
     Input:
     @ UIPinchGestureRecognizer: a pinch gesture recognizer
     Output:
     @ nil returnValue: nil
    */
    @objc func didPinch(sender: UIPinchGestureRecognizer) {
        
        guard let viewScene = sender.view as? VirtualARSCNView else { return }
        let pinchLocation = sender.location(in: viewScene)
        
        if sender.state == .began {
            // locate the object using a hit test
            selectedMeshNode = viewScene.getSCNNode(at: pinchLocation)!
            if selectedMeshNode.name == "planeNodeParent"{
                selectedMeshNode = SCNNode()
            }
        } else if sender.state == .changed {
            // scale the node which is detected in began session
            let pinchAction = SCNAction.scale(by: sender.scale, duration: 0)
            selectedMeshNode.runAction(pinchAction)
            sender.scale = 1.0
        } else if sender.state == .ended {
            
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
    @objc func didRotation(sender: UIRotationGestureRecognizer) {
        
        guard let viewScene = sender.view as? VirtualARSCNView else { return }
        let rotationLocation = sender.location(in: viewScene)
        
        if sender.state == .began {
            // locate the object using a hit test
            selectedMeshNode = viewScene.getSCNNode(at: rotationLocation)!
            if selectedMeshNode.name == "planeNodeParent"{
                selectedMeshNode = SCNNode()
            }
        } else if sender.state == .changed {
            // rotate the node which is detected in began session
            let rotationAction = SCNAction.rotateBy(x: 0, y: -sender.rotation, z: 0, duration: 0)
            selectedMeshNode.runAction(rotationAction)
            sender.rotation = 0.0
        } else if sender.state == .ended {
            
        }
    }
    
    /*
     Description:
     This function is used to deal with tap gesture, which is used to place a selected object on any detected plane in the scene
     Input:
     @ UITapGesturerecognizer: a tap gesture recognizer
     Output:
     @ nil returnValue: nil
    */
    @objc func didTap(sender: UITapGestureRecognizer) {
        guard let viewScene = sender.view as? VirtualARSCNView else { return }
        let touchLocation = sender.location(in: viewScene)
        
        if sender.state == .began{
        } else if sender.state == .changed {
        } else if sender.state == .ended {
            
            if let position = viewScene.getPlaneCoordination(at: touchLocation) {
                let scene = SCNScene(named: "\(selectedMeshName).scn", inDirectory: "art.scnassets")
                let node = (scene?.rootNode.childNode(withName: selectedMeshName, recursively: true))!
                node.position = position
                self.viewScene.scene.rootNode.addChildNode(node)
            }
        }
        
    }
    
    /*
     Description:
     This function is used to decide whether gesture recognizer can work with other gesture recognizer simultaneously
     Input:
     @ UIGestureRecognizer _ gestureRecognizer: a gesture recognizer
     @ UIGestureRecognizer shouldRecognizeSimultaneouslyWith otherGestureRecognizer: another gesture recognizer
     Output:
     @ Bool returnValue: can the given two recognizer work together or not
    */
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        switch gestureRecognizer {
        case is UILongPressGestureRecognizer:
            return false
        case is UIPanGestureRecognizer:
            if otherGestureRecognizer is UIRotationGestureRecognizer {
                return true
            } else {
                return false
            }
        case is UIPinchGestureRecognizer:
            return false
        case is UIRotationGestureRecognizer:
            if otherGestureRecognizer is UIPanGestureRecognizer {
                return true
            } else {
                return false
            }
        case is UITapGestureRecognizer:
            return false
        default:
            break
        }
        
        return false
    }
    
}
