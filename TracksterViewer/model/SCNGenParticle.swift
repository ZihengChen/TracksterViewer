//
//  SCNGenParticle.swift
//  TracksterViewer
//
//  Created by Ziheng Chen on 8/24/19.
//  Copyright © 2019 Ziheng Chen. All rights reserved.
//

import Foundation
import SceneKit
import ARKit


func getGenParticle(px : Float, py : Float, label : Int)->SCNNode{
    // line
    let origin = SCNVector3(0, 0, 0)
    
    let genpartPosition = SCNVector3(px, py, 320)
    
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
    let nodeGenpart = getCylinderLineNode(v1: origin, v2: genpartPosition, r: 0.2, c:materialColor)
    
    return nodeGenpart
}


extension SCNVector3 {
    func distance(to destination: SCNVector3) -> CGFloat {
        let dx = destination.x - x
        let dy = destination.y - y
        let dz = destination.z - z
        return CGFloat(sqrt(dx*dx + dy*dy + dz*dz))
    }
}

func getCylinderLineNode(v1 : SCNVector3, v2 : SCNVector3, r: CGFloat, c: UIColor) -> SCNNode {
    
    // Create Cylinder Geometry
    let line = SCNCylinder(radius: r, height: v1.distance(to: v2))
    
    // Create Material
    let material = SCNMaterial()
    material.diffuse.contents = c
    material.lightingModel = .phong
    line.materials = [material]
    
    // Create Cylinder(line) Node
    let nodeLine = SCNNode()
    nodeLine.geometry = line
    
    
    // This is the change in x,y and z between node1 and node2
    let dirVector = SCNVector3Make( v2.x - v1.x, v2.y - v1.y, v2.z - v1.z)
    
    // Get Y rotation in radians
    let dirR = sqrt(dirVector.x*dirVector.x + dirVector.y*dirVector.y)
    
    
    nodeLine.eulerAngles.x = -.pi / 2
    if dirVector.x>0 {
        nodeLine.eulerAngles.y = atan( dirR / dirVector.z)
    } else {
        nodeLine.eulerAngles.y = -atan( dirR / dirVector.z)
    }
    
    nodeLine.eulerAngles.z = atan( dirVector.y / dirVector.x )
    
    nodeLine.position = SCNVector3(x: (v1.x+v2.x)/2, y: (v1.y+v2.y)/2, z: (v1.z+v2.z)/2)
    
    return nodeLine
    
}






