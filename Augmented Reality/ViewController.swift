//
//  ViewController.swift
//  Augmented Reality
//
//  Created by student on 12.05.2018.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        /// точка начала координат
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin]
        
        sceneView.automaticallyUpdatesLighting = true
        
        //loadCampus()
        loadHouse()
    }

    func loadHouse() {
        
        let scene = SCNScene(named: "art.scnassets/house.scn")
        
        let node = scene?.rootNode.clone()
        
        sceneView.scene.rootNode.addChildNode(node!)
 
    }
    
    func loadCampus() {
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        loadMainBuilding()
        
        // загрузить дорожки
        loadSidewalks()
        
        // загрузить траву
        loadGrass()
        
        // загрузить дерево
        for x in -2...2 {
            for y in -2...2 {
                loadTree(x: Float(x), y: Float(y), z: 0)
            }
        }
        
    }
    
    func loadMainBuilding() {
        let node = SCNNode()
        
        node.position = SCNVector3(-2, -2, -1.5)
        
        let geometry = SCNBox(width: 3, height: 3, length: 3, chamferRadius: 0)
        geometry.firstMaterial?.diffuse.contents = UIColor.brown
        node.geometry = geometry
        
        node.scale = SCNVector3(0.5, 0.5, 0.5)
        
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    func loadSidewalks() {
        let node = SCNNode()
        
        let geometry = SCNPlane(width: 3.5, height: 3.5)
        geometry.firstMaterial?.diffuse.contents = UIColor.gray
        geometry.firstMaterial?.isDoubleSided = true
        node.geometry = geometry
        node.eulerAngles = SCNVector3(-Float.pi / 2, 0, 0)
        
        let position = SCNVector3(-2, -2, -2)
        node.position = position
        
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    func loadGrass() {
        let node = SCNNode()
        
        let geometry = SCNPlane(width: 4.5, height: 2)
        geometry.firstMaterial?.diffuse.contents = UIColor.green
        geometry.firstMaterial?.isDoubleSided = true
        node.geometry = geometry
        node.eulerAngles.x = -Float.pi / 2
        
        let position = SCNVector3(-2, -2.01, -2)
        node.position = position
        
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    func loadTree(x: Float, y: Float, z: Float) {
        let trunkNode = SCNNode()
        
        let trunkGeometry = SCNCylinder(radius: 0.05, height: 0.5)
        trunkGeometry.firstMaterial?.diffuse.contents = UIColor.brown
        trunkNode.geometry = trunkGeometry
        
        let trunkPosition = SCNVector3(x, z, y)
        trunkNode.position = trunkPosition
        
        sceneView.scene.rootNode.addChildNode(trunkNode)
        
        
        
        let crownNode = SCNNode()
        
        let crownGeometry = SCNSphere(radius: 0.2)
        crownGeometry.firstMaterial?.diffuse.contents = UIColor.green
        crownNode.geometry = crownGeometry
        
        let crownPosition = SCNVector3(0, 0.25, 0)
        crownNode.position = crownPosition
        
        trunkNode.addChildNode(crownNode)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
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
}
