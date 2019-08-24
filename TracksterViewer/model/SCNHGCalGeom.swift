//
//  SCNHGCalGeom.swift
//  TracksterViewer
//
//  Created by Ziheng Chen on 8/24/19.
//  Copyright © 2019 Ziheng Chen. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

func getHGCalGeometryNode() -> SCNNode {
    
    let hgcalMaterial = SCNMaterial()
    hgcalMaterial.diffuse.contents = UIColor.black
    hgcalMaterial.lightingModel = .phong
    
    
    let nodeHGCalGeometry = SCNNode()
    // EE
    var hgcalPart = SCNCone(topRadius: 153.0, bottomRadius: 197.0, height: 35.0+60.0)
    hgcalPart.materials = [hgcalMaterial]
    let nodeEE = SCNNode(geometry: hgcalPart)
    nodeEE.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
    nodeEE.position =  SCNVector3(0.0, 0.0, (320.0 + Double(hgcalPart.height/2)))
    nodeEE.opacity = 0.2
    nodeHGCalGeometry.addChildNode(nodeEE)
    
//    // FH
//    hgcalPart = SCNCone(topRadius: 170.0, bottomRadius: 197.0, height: 60.0)
//    hgcalPart.materials = [hgcalMaterial]
//    let nodeFH = SCNNode(geometry: hgcalPart)
//    nodeFH.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
//    nodeFH.position =  SCNVector3(0.0, 0.0, (355.0 + Double(hgcalPart.height/2)))
//    nodeFH.opacity = 0.3
//    nodeHGCalGeometry.addChildNode(nodeFH)
    
    // BH1
    hgcalPart = SCNCone(topRadius: 197.0, bottomRadius: 250.0, height: 60.0)
    hgcalPart.materials = [hgcalMaterial]
    let nodeBH1 = SCNNode(geometry: hgcalPart)
    nodeBH1.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
    nodeBH1.position =  SCNVector3(0.0, 0.0, (415.0 + Double(hgcalPart.height/2)))
    nodeBH1.opacity = 0.2
    nodeHGCalGeometry.addChildNode(nodeBH1)
    
    // BH2
    hgcalPart = SCNCone(topRadius: 250.0, bottomRadius: 256.0, height: 45.0)
    hgcalPart.materials = [hgcalMaterial]
    let nodeBH2 = SCNNode(geometry: hgcalPart)
    nodeBH2.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
    nodeBH2.position =  SCNVector3(0.0, 0.0, (475.0 + Double(hgcalPart.height/2)))
    nodeBH2.opacity = 0.2
    nodeHGCalGeometry.addChildNode(nodeBH2)
    
    
    
    // beampipe
    let beampipeMaterial = SCNMaterial()
    beampipeMaterial.diffuse.contents = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
    beampipeMaterial.lightingModel = .phong
    
    
    hgcalPart = SCNCone(topRadius: 32.0, bottomRadius: 55.0, height: 220.0)
    hgcalPart.materials = [beampipeMaterial]
    let nodeBeampipe = SCNNode(geometry: hgcalPart)
    nodeBeampipe.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
    nodeBeampipe.position =  SCNVector3(0.0, 0.0, (310.0 + Double(hgcalPart.height/2)))
    nodeBeampipe.opacity = 1.0
    nodeHGCalGeometry.addChildNode(nodeBeampipe)
    
    
    // axis
    let axisMaterial = SCNMaterial()
    axisMaterial.diffuse.contents = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    axisMaterial.lightingModel = .phong
    
    let zAxix  = SCNCylinder(radius: 2, height: 550)
    zAxix.materials = [axisMaterial]
    let nodeZAxix = SCNNode(geometry: zAxix)
    nodeZAxix.eulerAngles.x = -.pi / 2
    nodeZAxix.position = SCNVector3(x: 0, y: 0, z: Float(zAxix.height/2))
    nodeHGCalGeometry.addChildNode(nodeZAxix)
    
    
    
    
    return nodeHGCalGeometry
}








