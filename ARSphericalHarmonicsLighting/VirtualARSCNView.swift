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
        let hitTestOption: [SCNHitTestOption: Any] = [.boundingBoxOnly: true]
        let hitTestResult = hitTest(point, options: hitTestOption)
        
        return hitTestResult.lazy.compactMap{ result in
            return ARSCNObject.getExistingARSCNObjectContaingNode(node: result.node)
        }.first
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
