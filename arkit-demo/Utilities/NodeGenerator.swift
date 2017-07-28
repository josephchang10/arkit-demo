//
//  NodeGenerator.swift
//  arkit-demo
//
//  Created by 张嘉夫 on 2017/7/28.
//  Copyright © 2017年 张嘉夫. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

struct NodeGenerator {
    
    static func generateSphereInFrontOf(node: SCNNode) -> SCNNode {
        let radius = (0.02...0.06).random()
        let sphere = SCNSphere(radius: CGFloat(radius))
        
        let color = SCNMaterial()
        color.diffuse.contents = randomColor()
        sphere.materials = [color]
        
        let sphereNode = SCNNode(geometry: sphere)
        
        let position = SCNVector3(x: 0, y: 0, z: -1)
        sphereNode.position = node.convertPosition(position, to: nil)
        sphereNode.rotation = node.rotation
        
        return sphereNode
    }
    
    static func generateCubeInFrontOf(node: SCNNode, physics: Bool) -> SCNNode {
        let width = CGFloat((0.06...0.1).random())
        let height = CGFloat((0.06...0.1).random())
        let length = CGFloat((0.06...0.1).random())
        let box = SCNBox(width: width, height: height, length: length, chamferRadius: 0)
        
        let color = SCNMaterial()
        color.diffuse.contents = randomColor()
        box.materials = [color]
        
        let boxNode = SCNNode(geometry: box)
        
        let position = SCNVector3(x: 0, y: 0, z: -1)
        boxNode.position = node.convertPosition(position, to: nil)
        boxNode.rotation = node.rotation
        
        if physics {
            let physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: box, options: nil))
            physicsBody.mass = 1.25
            physicsBody.restitution = 0.25
            physicsBody.friction = 0.75
            physicsBody.categoryBitMask = CollisionTypes.shape.rawValue
            boxNode.physicsBody = physicsBody
        }
        
        return boxNode
    }
    
    private static func randomColor() -> UIColor {
        return UIColor(hue: CGFloat(drand48()), saturation: 1, brightness: 1, alpha: 1)
    }
}

extension ClosedRange where Bound: FloatingPoint {
    public func random() -> Bound {
        let range = upperBound - lowerBound
        let randomValue = (Bound(arc4random_uniform(UINT32_MAX)) / Bound(UINT32_MAX)) * range + lowerBound
        return randomValue
    }
}

struct CollisionTypes : OptionSet {
    let rawValue: Int
    
    static let bottom = CollisionTypes(rawValue: 1 << 0)
    static let shape = CollisionTypes(rawValue: 1 << 1)
}
