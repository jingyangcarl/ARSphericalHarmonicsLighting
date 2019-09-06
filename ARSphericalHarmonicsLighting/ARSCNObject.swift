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
    
    // object's realworld anchor
    var anchor: ARAnchor?
    
    /*
     Description:
     This function is used to get the existing ARSCNObject which is the parent of provided node.
     Input:
     @ SCNNode node: a given SCNNode
     Output:
     @ ARSCNObject? returnValue: a ARSCNObject
    */
    static func getExistingARSCNObjectContaningNode(node: SCNNode) -> ARSCNObject? {
        if let ARSCNObjectRoot = node as? ARSCNObject {
            return ARSCNObjectRoot
        }
        
        guard let parentNode = node.parent else { return nil }
        
        // Recurse up to check if the parent is an `ARSCNObject`.
        return getExistingARSCNObjectContaningNode(node: parentNode)
    }
    
    /*
     
    */
    func setTransform(_ newTransform: float4x4, relativeTo cameraTransform: float4x4) {
        let cameraWorldPosition = cameraTransform.columns.3
        var positionOffsetFromCamera = newTransform.columns.3 - cameraWorldPosition
        
        // Limit the distance of the object from the camera to a maximum of 5 meters.
        if simd_length(positionOffsetFromCamera) > 10 {
            positionOffsetFromCamera = simd_normalize(positionOffsetFromCamera)
            positionOffsetFromCamera *= 10
        }
        
        simdPosition = simd_make_float3(cameraWorldPosition + positionOffsetFromCamera)
    }
    
    
}
