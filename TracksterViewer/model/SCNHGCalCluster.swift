//
//  SCNHGCalCluster.swift
//  TracksterViewer
//
//  Created by Ziheng Chen on 8/24/19.
//  Copyright © 2019 Ziheng Chen. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

func getHGCalCluster(px : Float, py : Float, pz : Float, size : Float, label :  Int)->SCNNode{

    
    let cluster = SCNPlane(width: CGFloat(size), height: CGFloat(size))
    // Create Material
    let material = SCNMaterial()
    
    var materialColor = UIColor()
    switch (label) {
        case -1: materialColor = UIColor.black
        case 0: materialColor = UIColor.blue
        case 1: materialColor = UIColor.red
        case 2: materialColor = UIColor.green
        case 3: materialColor = UIColor.purple
        case 4: materialColor = UIColor.orange
        default: materialColor = UIColor.black
    }
    material.diffuse.contents = materialColor
    material.lightingModel = .phong
    material.isDoubleSided = true
    cluster.materials = [material]
    
    let nodeCluster = SCNNode()
    nodeCluster.geometry = cluster
    
    let zrand = Float.random(in: -0.5 ..< 0.5)
    nodeCluster.position = SCNVector3(px, py, pz+zrand)
    nodeCluster.eulerAngles = SCNVector3(Float.pi, 0, 0)
    nodeCluster.opacity = 0.5
    return nodeCluster
}
