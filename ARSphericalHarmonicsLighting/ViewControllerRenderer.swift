//
//  ViewControllerRenderer.swift
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
     This function is used to generate a plane node based on a ARPlaneAnchor, which includes information about the position and orientation of a real-world flat surface detected in a world-tracking session
     Input:
     @ ARPlaneAnchor planeAnchor: an ARPlaneAnchor
     Output:
     @ SCNNode: a generated plane node
    */
    func createPlaneNode(planeAnchor: ARPlaneAnchor) -> SCNNode {
        
        // set plane size
        let width = planeAnchor.extent.x
        let height = planeAnchor.extent.z
        
        // set icon unit scalor, where the larger value, the smaller icon
        let scalor = Float(40)
        
        // generate a plane node
        let planeNode = SCNNode(geometry: SCNPlane(width: CGFloat(width), height: CGFloat(height)))
        planeNode.name = "planeNode"
        
        // set plane texture
        planeNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Grid.png")
        planeNode.geometry?.firstMaterial?.transparency = 0.8
        planeNode.geometry?.firstMaterial?.isDoubleSided = true
        planeNode.geometry?.firstMaterial?.lightingModel = .constant
        planeNode.geometry?.firstMaterial?.diffuse.contentsTransform = SCNMatrix4MakeScale(Float(width * scalor), Float(height * scalor), 0)
        planeNode.geometry?.firstMaterial?.diffuse.wrapS = .repeat
        planeNode.geometry?.firstMaterial?.diffuse.wrapT = .repeat
        
        // set plane position
        planeNode.position = SCNVector3(planeAnchor.center.x, planeAnchor.center.y, planeAnchor.center.z)
        
        // set plane rotation
        planeNode.eulerAngles = SCNVector3(90.degree2Radian, 0, 0)
        
        // set rendering order
        planeNode.renderingOrder = 10
        
        return planeNode
    }
    
    /*
     Description:
     This function is used to generate a cursor node based on a ARPlaneAnchor, which includes information about the position and orientation of a real-world flat surface detected in a world-tracking session, the cursor is quite the same as plane node, but will be only used as a notification of plane detection, where the plane node will only show up in debug mode
     Input:
     @ ARHitTestResult: a hit test result
     Output:
     @ SCNNode: a generated plane node
    */
    func createCursorNode(hitTest: ARHitTestResult) -> SCNNode {
        
        // generate a cursor node
        let cursorNode = SCNNode(geometry: SCNPlane(width: 0.05, height: 0.05))
        cursorNode.name = "cursor"
        
        // set cursor texture
        cursorNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Cursor.png")
        cursorNode.geometry?.firstMaterial?.isDoubleSided = true
        cursorNode.geometry?.firstMaterial?.lightingModel = .constant
        
        // set cursor position
        let position = hitTest.worldTransform.columns.3
        cursorNode.position = SCNVector3(position.x, position.y, position.z)
        
        // set cursor rotation
        cursorNode.eulerAngles = SCNVector3(-90.degree2Radian, 0, 0)
        
        // set rendering order
        cursorNode.renderingOrder = 0
        
        return cursorNode
    }
    
    /*
     Description:
     This function is an interfce from ARSCNViewDelegate, which is called whenever an ARAnchor is discovered. In this case, when an ARPlaneAnchor is discovered, the function is triggered
     Input:
     @ SCNSceneRenderer _ render: the ARSCNView object rendering the scene
     @ SCNNode didAdd nodd: the newly added SceneKit node, which is a child node of sceneView rootnode
     @ ARAnchor for anchor: the AR anchor corresponding to the node
     Output:
     @ nil returnValue: nil
     */
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        // notification for adding a node
        DispatchQueue.main.async {
            self.feedbackSelection.selectionChanged()
        }
        
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        // name the node, which is a child of scene view rootnode
        node.name = "planeNodeParent"
        
        // add plane node
        let planeNode = createPlaneNode(planeAnchor: planeAnchor)
        node.addChildNode(planeNode)
        viewScene.scene.rootNode.addChildNode(node)
    }
    
    /*
     Description:
     This function is an interface from ARSCNViewDelegate, which is called whenever an ARAnchor is updated. In this case, when an ARPlaneAnchor is updated, the function is triggered
     Input:
     @ SCNSceneRenderer _ render: the ARSCNView object rendering the scene
     @ SCNNode didUpdate nodd: the updated SceneKit node, which is a child node of sceneView rootnode
     @ ARAnchor for anchor: the AR anchor corresponding to the node
     Output:
     @ nil returnValue: nil
     */
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        // remove the previous plane node
        node.enumerateChildNodes{ (childNode, _) in
            childNode.removeFromParentNode()
        }
        
        // add new node
        let planeNode = createPlaneNode(planeAnchor: planeAnchor)
        node.addChildNode(planeNode)
    }
    
    /*
     Description:
     This function is an interface from ARSCNViewDelegate, which is called exactly once per frame. In this case, the function is triggered to render to cursor.
     Input:
     @ SCNSceneRenderer _ renderer: the ARSCNView object rendering the scene
     @ Timeinterval updateAtTime time: the current system time
     Output:
     @ nil returnValue: nil
     */
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        // set screen center
        DispatchQueue.main.async {
            self.screenCenter = CGPoint(x: self.viewScene.bounds.midX, y: self.viewScene.bounds.midY)
        }
        
        // clear previous cursor node
        viewScene.scene.rootNode.enumerateChildNodes({ (node, _) in
            if node.name == "cursor" {
                node.removeFromParentNode()
            }
        })
        
        // set cursor hidden status
        let hitTest = self.viewScene.hitTest(screenCenter, types: [.existingPlaneUsingExtent])
        if !hitTest.isEmpty {
            // hide button cursor
            DispatchQueue.main.async {
                self.buttonCursor.isHidden = true
            }
            // add scene plane cursor
            let cursorNode = self.createCursorNode(hitTest: hitTest.first!)
            viewScene.scene.rootNode.addChildNode(cursorNode)
        } else {
            // show button cursor
            DispatchQueue.main.async {
                self.buttonCursor.isHidden = false
            }
        }
        
        // set plane hidden status
        if isShowDetectedPlanes == true {
            viewScene.scene.rootNode.enumerateChildNodes{ (node, _) in
                if node.name == "planeNodeParent" {
                    node.isHidden = false
                }
            }
        } else {
            viewScene.scene.rootNode.enumerateChildNodes{ (node, _) in
                if node.name == "planeNodeParent" {
                    node.isHidden = true
                }
            }
        }
    }
    
    /*
     Description:
     This function is an interface from ARSCNViewDelegate, which is called when a plane anchor is removed from the scene
     Input:
     @ SCNSceneRenderer _ render: the ARSCNView object rendering the scene
     @ SCNNode didRemove nodd: the removed SceneKit node, which is a child node of sceneView rootnode
     @ ARAnchor for anchor: the AR anchor corresponding to the node
     Output:
     @ nil returnValue: nil
     */
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard let _ = anchor as? ARPlaneAnchor else { return }
        
        // remove node from parent
        node.enumerateChildNodes{ (childNode, _) in
            childNode.removeFromParentNode()
        }
    }
    
}
