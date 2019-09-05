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
     This function is used to perform a hittest at given point and return an ARSCNObject if it exist
     Input:
     @ CGPoint at point: a given location to have hit test
     Output:
     @ ARSCNObject? returnValue: an ARSCNObject
    */
    func getARSCNObject(at point: CGPoint) -> ARSCNObject? {
        print(point)
        let hitTestOption: [SCNHitTestOption: Any] = [.boundingBoxOnly: true]
        let hitTestResult = hitTest(point, options: hitTestOption)
        
        return hitTestResult.lazy.compactMap{ result in
            return ARSCNObject.getExistingARSCNObjectContaningNode(node: result.node)
        }.first
    }
    
    /*
     Description:
     This function is used to perform a hittest aganst horizontal planes, where the horizontal planes may be infinite or not. If the plane if infinite, the hitTest will test all planes and return the nearet one which is within 5 cm of the object's position.
     Input:
     @ CGPoint at Point: a given CGPoint on screen
     @ isInfinitePlane: whether the plane should be infinite or not
     @ SCNVector3? at objectPosition: a given object position
     Output:
     @ ARHitTestResult? returnValue: a hit test result
    */
    func planeHitTest(at point: CGPoint, isInfinitePlane: Bool = false, at objectPosition: float3? = nil) -> ARHitTestResult? {
        
        // perform hit test at given point
        let results = hitTest(point, types: [.existingPlaneUsingGeometry, .estimatedHorizontalPlane])
        
        // check results based on existingPlaneUsingGeometry
        if let existingPlaneUsingGeometryResult = results.first(where: {$0.type == .existingPlaneUsingGeometry}), let planeAnchor = existingPlaneUsingGeometryResult.anchor as? ARPlaneAnchor, planeAnchor.alignment == .horizontal {
            return existingPlaneUsingGeometryResult
        }
        
        // check results on existing plane assuming the plane is a infinite plane
        // loop through all hit restuls againt infinite planes
        // and return the nearest one which is within 5 cm of the object's position
        if isInfinitePlane == true {
            let infinitePlaneResults = hitTest(point, types: .existingPlane)
            
            for infinitePlaneResult in infinitePlaneResults {
                if let planeAnchor = infinitePlaneResult.anchor as? ARPlaneAnchor, planeAnchor.alignment == .horizontal {
                    if let objectY = objectPosition?.y {
                        let distance = Float(0.05)
                        let planeY = Float(infinitePlaneResult.worldTransform.columns.3.y)
                        if objectY > planeY - distance && objectY < planeY + distance {
                            return infinitePlaneResult
                        }
                    } else {
                        return infinitePlaneResult
                    }
                }
            }
        }
        
        // check results on esitmated plane
        return results.first(where: {$0.type == .estimatedHorizontalPlane})
    }
    
    func updateARSCNObjectAnchor(for object: ARSCNObject) {
        
        
    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
