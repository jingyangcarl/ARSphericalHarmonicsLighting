//
//  VirtualARSCNViewGestureRecognizer.swift
//  ARSphericalHarmonicsLighting
//
//  Created by Jing Yang on 9/4/19.
//  Copyright © 2019 Jing Yang. All rights reserved.
//

import UIKit
import ARKit

class VirtualARSCNViewGestureRecognizer: NSObject, UIGestureRecognizerDelegate {
    // the class is designed since VirtualARSCNView is derived from ARSCNView,
    // GestureRecognizer has to access VirtualARSCNView
    
    let viewScene: VirtualARSCNView
    
    var selectedObject: ARSCNObject?
    
    init(viewScene: VirtualARSCNView) {
        self.viewScene = viewScene
        super.init()
        
        // init gesture recognizers
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(didPinch))
        let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(didRotation))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        
        // add Gesture recognizer to scene
        viewScene.addGestureRecognizer(longPressGestureRecognizer)
        viewScene.addGestureRecognizer(panGestureRecognizer)
        viewScene.addGestureRecognizer(pinchGestureRecognizer)
        viewScene.addGestureRecognizer(rotationGestureRecognizer)
        viewScene.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didLongPress(sender: UILongPressGestureRecognizer) {
        print("didLongPress")
    }
    
    @objc func didPan(sender: UIPanGestureRecognizer) {
        print("didPan")
    }
    
    @objc func didPinch(sender: UIPinchGestureRecognizer) {
        print("didPinch")
    }
    
    @objc func didRotation(sender: UIRotationGestureRecognizer) {
        print("didRotation")
    }
    
    @objc func didTap(sender: UITapGestureRecognizer) {
        print("didTap")
        let touchLocation = sender.location(in: viewScene)
        
        if let touchedObject = viewScene.getARSCNObject(at: touchLocation) {
            selectedObject = touchedObject
        } else {
            
        }
    }
    
    func translate(object: ARSCNObject, screenPos: CGPoint, isInfinitePlane: Bool, allowAnimation: Bool) {
        guard let cameraTransform = viewScene.session.currentFrame?.camera.transform else { return }
        guard let hitTestResult = viewScene.planeHitTest(at: screenPos, isInfinitePlane: true, at: object.simdWorldPosition) else { return }
        
        let transform = hitTestResult.worldTransform
        let isOnPlane = hitTestResult.anchor is ARPlaneAnchor
        object.setTransform()
    }
    
    
}
