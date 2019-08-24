//
//  ViewController.swift
//  TracksterViewer
//
//  Created by Ziheng Chen on 8/24/19.
//  Copyright © 2019 Ziheng Chen. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import Photos

class ViewController: UIViewController, ARSCNViewDelegate {
    
    let nodeRoot = SCNNode()
    let eventList = [1,2]
    

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.sceneView.debugOptions = [SCNDebugOptions.showFeaturePoints]
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.autoenablesDefaultLighting = false
        
        // hgcal node
        let nodeHGCal = SCNNode()
        nodeHGCal.addChildNode(getHGCalGeometryNode())
        for eventid in eventList {
            let (dataGenPart, dataCluster) = readDataFromCSV(fileName: "data/event" + String(eventid))!
            for genpart in dataGenPart {
                let x = Float(genpart[0])!
                let y = Float(genpart[1])!
                let l = Int(genpart[2])!
                let nodeGenParticle = getGenParticle(px: x, py: y, label: l)
                nodeHGCal.addChildNode(nodeGenParticle)
            }
            for cluster in dataCluster {
                let x = Float(cluster[0])!
                let y = Float(cluster[1])!
                let z = Float(cluster[2])!
                let e = Float(cluster[3])!
                let l = Int(cluster[4])!
                let nodeGenParticle = getHGCalCluster(px: x, py: y, pz: z, energy: e, label: l)
                nodeHGCal.addChildNode(nodeGenParticle)
            }
        }

        nodeHGCal.scale = SCNVector3(0.001,0.001,-0.001)
        nodeHGCal.position = SCNVector3(0,0,0.550)
        
        nodeRoot.addChildNode(nodeHGCal)


        
        // create main light that cast shadow
        let lightNode2 = SCNNode()
        lightNode2.light = SCNLight()
        lightNode2.light!.type = .directional//.spot
        lightNode2.position = SCNVector3(x: 5, y: 5, z: 0)
        lightNode2.eulerAngles = SCNVector3(-1*Float.pi/4, 1*Float.pi/4, 0)
        lightNode2.light?.color = UIColor.white
        lightNode2.light?.intensity = 1000
        lightNode2.light?.shadowRadius = 8
        nodeRoot.addChildNode(lightNode2)
        
        // create ambient light
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.intensity = 300
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.white
        nodeRoot.addChildNode(ambientLightNode)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if ARWorldTrackingConfiguration.isSupported {
            let configuration = ARWorldTrackingConfiguration()
            configuration.planeDetection = .vertical
            sceneView.session.run(configuration)
        }
        else  {
            let configuration = AROrientationTrackingConfiguration()
            sceneView.session.run(configuration)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    

    
    // MARK -- touchesScreen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: sceneView)

            let results = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)

            if let hitResult = results.first{
                nodeRoot.removeFromParentNode()
                nodeRoot.position = SCNVector3(
                    x: hitResult.worldTransform.columns.3.x,
                    y: hitResult.worldTransform.columns.3.y,
                    z: hitResult.worldTransform.columns.3.z
                )
                sceneView.scene.rootNode.addChildNode(nodeRoot)
            }

            if !results.isEmpty {
                print("touched the plane")
            }else{
                print( "Please finish scanning a plane and touch inside the plane.")
            }
        }
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor{
            print("plane detected")
            
            
            let planeAnchor = anchor as! ARPlaneAnchor
            
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x/2), height: CGFloat(planeAnchor.extent.x/2))

            let planeNode = SCNNode()
            
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)

            planeNode.position = SCNVector3(x: planeAnchor.center.x, y:planeAnchor.center.y, z:  planeAnchor.center.z)



            let gridMaterial = SCNMaterial()

            gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid2.png")

            plane.materials = [gridMaterial]

            planeNode.geometry =  plane

            node.addChildNode(planeNode)
        
        } else{
            return
        }
   
    }

    

}


