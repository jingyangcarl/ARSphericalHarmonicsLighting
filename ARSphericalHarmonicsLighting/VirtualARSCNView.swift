//
//  VirtualARSCNView.swift
//  ARSphericalHarmonicsLighting
//
//  Created by Jing Yang on 8/30/19.
//  Copyright © 2019 Jing Yang. All rights reserved.
//

import UIKit
import ARKit

class VirtualARSCNView: ARSCNView {
    
    /*
     Description:
     This function is used to perform a hit test at given point and return an SCNNode if it exist
     Input:
     @ CGPoint at point: a given location to perform hit test
     @ Bool isDetectedPlaneConsidered: if a detected plane is found in hit test result, return or not
     Output:
     @ SCNNode? returnValue: an SCNNode
    */
    func getSCNNode(at point: CGPoint, isDetectedPlaneConsidered: Bool = false) -> SCNNode? {
        let hitTestResult = hitTest(point)
        if !hitTestResult.isEmpty {
            // the hit test can only find the real mesh which may be the child node of a mesh
            // remember to find the parent node for that mesh
            
            if (isDetectedPlaneConsidered) {
                return hitTestResult.first?.node.parent
            } else {
                
                if (hitTestResult.first?.node.parent?.name == "planeNodeParent") {
                    return SCNNode()
                } else {
                    return hitTestResult.first?.node.parent
                }
                
            }

        } else {
            return SCNNode()
        }
    }
    
    /*
     Description:
     This function is used to perform a hit test at given point and return the location on a horizontal plane if it exist
     Input:
     @ CGPoint at point: a given locaitno to perform a hit test
     Output:
     @ SCNVector3? returnValue: a position coordinate on the plane
    */
    func getPlaneCoordination(at point: CGPoint) -> SCNVector3? {
        let planeHitTestResult = hitTest(point, types: [.existingPlaneUsingExtent])
        if !planeHitTestResult.isEmpty {
            let position = planeHitTestResult.first?.worldTransform.columns.3
            return SCNVector3(position!.x, position!.y, position!.z)
        } else {
            return nil
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
