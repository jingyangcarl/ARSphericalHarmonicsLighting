//
//  ARSCNObject.swift
//  ARSphericalHarmonicsLighting
//
//  Created by Jing Yang on 8/30/19.
//  Copyright © 2019 Jing Yang. All rights reserved.
//

import UIKit
import ARKit

class ARSCNObject: SCNReferenceNode {

    /*
     Description:
     This function is used to get the existing ARSCNObject which is the parent of provided node.
     Input:
     @ SCNNode node: a given SCNNode
     Output:
     @ ARSCNObject? returnValue: a ARSCNObject
    */
    static func getExistingARSCNObjectContaingNode(node: SCNNode) -> ARSCNObject? {
        if let ARSCNObjectRoot = node as? ARSCNObject {
            return ARSCNObjectRoot
        }
        
        guard let parentNode = node.parent else { return nil }
        
        // Recurse up to check if the parent is an `ARSCNObject`.
        return getExistingARSCNObjectContaingNode(node: parentNode)
    }
}
