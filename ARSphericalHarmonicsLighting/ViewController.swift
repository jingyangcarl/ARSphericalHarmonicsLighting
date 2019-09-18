//
//  ViewController.swift
//  ARSphericalHarmonicsLighting
//
//  Created by Jing Yang on 8/20/19.
//  Copyright © 2019 Jing Yang. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var viewScene: VirtualARSCNView!
    @IBOutlet weak var viewDebug: UIView!
    @IBOutlet weak var viewMesh: UIView!
    
    var isDebugMenuShowed: Bool = false
    var isMeshMenuShowed: Bool = false
    @IBOutlet weak var buttonDebug: UIButton!
    @IBOutlet weak var buttonReset: UIButton!
    @IBOutlet weak var buttonMesh: UIButton!
    @IBOutlet weak var buttonCursor: UIButton!
    
    // AR word tracking configuratino
    var configuration: ARWorldTrackingConfiguration = ARWorldTrackingConfiguration()
    
    // mobile screen info
    var screenCenter: CGPoint = CGPoint(x: 0.0, y: 0.0)
    
    // feedback options
    let feedbackImpact: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator()
    let feedbackSelection: UISelectionFeedbackGenerator = UISelectionFeedbackGenerator()
    let feedbackNotification: UINotificationFeedbackGenerator = UINotificationFeedbackGenerator()
    
    // debug options
    var isShowBoundingBoxes: Bool = false
    var isShowDetectedPlanes: Bool = false
    var isShowFeaturePoints: Bool = false
    var isShowWorldOrigin: Bool = false
    var isShowWireframe: Bool = false
    
    // mesh selection
    var selectedMeshName: String = "cube"
    var selectedMeshNode: SCNNode = SCNNode()
    
    // virtual gesture recognizer
    // lazy var virtualARSCNViewGestureRecognizer = VirtualARSCNViewGestureRecognizer(viewScene: viewScene)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        viewScene.delegate = self
        
        // Show statistics such as fps and timing information
        viewScene.showsStatistics = true
        
        // Create a new scene
        // let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        // sceneView.scene = scene
        
        // Initialize buttons
        buttonInit()
        
        // Initialize Views
        viewInit()
        
        // Initialize gesture recognizer
        registerGestureRecognizers()
        
        // Initialize light
//        viewScene.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        configuration = ARWorldTrackingConfiguration()
        
        // Enable plane detection
        configuration.planeDetection = .horizontal
        
        // Enable environment texturing
        configuration.environmentTexturing = .automatic

        // Run the view's session
        viewScene.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        viewScene.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    /*
     Description:
     This function is used to initialize view status including alpha value, etc.
     Input:
     @ nil parameter: nil
     Output:
     @ nil returnValue: nil
    */
    func viewInit() {
        // hide 
        viewDebug.alpha = 0.0
        viewDebug.isHidden = true
        viewDebug.backgroundColor = UIColor.clear
        
        viewMesh.alpha = 0.0
        viewMesh.isHidden = true
        viewMesh.backgroundColor = UIColor.clear
    }
    
}


extension Int {
    /*
     Description:
     This function is used to convert degree value to raidan value
     Input:
     @ Double parameter: a degree value
     Output:
     @ Double returnValue: a radian value
    */
    var degree2Radian: Double {
        return Double(self) * .pi / 180
    }
}
