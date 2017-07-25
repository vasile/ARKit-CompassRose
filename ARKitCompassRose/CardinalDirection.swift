//
//  CardinalDirection.swift
//  ARKitCompassRose
//
//  Created by Vasile Cotovanu on 25.07.17.
//  Copyright © 2017 vasile.ch. All rights reserved.
//

import UIKit
import SceneKit

class CardinalDirection: NSObject {
    var name: String
    var angle: Float
    
    init(name: String, angle: Float) {
        self.name = name
        self.angle = angle
        
        super.init()
    }
    
    func sphere() -> SCNNode {
        let sphere = SCNSphere(radius: 1)
        
        let sphereMaterial = SCNMaterial()
        sphereMaterial.diffuse.contents = UIColor.red
        
        let node = SCNNode(geometry: sphere)
        node.geometry?.materials = [sphereMaterial]
        
        node.transform = CardinalDirection.transform(rotationY: GLKMathDegreesToRadians(angle), distance: 100)
        
        return node
    }
    
    func text() -> SCNNode {
        let textBlock = SCNText(string: "\(name) \(angle)°", extrusionDepth: 0.5)
        textBlock.firstMaterial?.diffuse.contents = UIColor.blue
        
        let node = SCNNode(geometry: textBlock)
        node.transform = CardinalDirection.transform(rotationY: GLKMathDegreesToRadians(angle), distance: 100)
        
        return node
    }
    
    static func transform(rotationY: Float, distance: Int) -> SCNMatrix4 {
        
        // Translate first on -z direction
        let translation = SCNMatrix4MakeTranslation(0, 0, Float(-distance))
        // Rotate (yaw) around y axis
        let rotation = SCNMatrix4MakeRotation(-1 * rotationY, 0, 1, 0)
        
        // Final transformation: TxR
        let transform = SCNMatrix4Mult(translation, rotation)
        
        return transform
    }
}

extension CardinalDirection {
    static let defaults: [CardinalDirection] = {
        return[
            CardinalDirection(name: "N", angle: 0),
            CardinalDirection(name: "NE", angle: 45),
            CardinalDirection(name: "E", angle: 90),
            CardinalDirection(name: "SE", angle: 135),
            CardinalDirection(name: "S", angle: 180),
            CardinalDirection(name: "SW", angle: 225),
            CardinalDirection(name: "W", angle: 270),
            CardinalDirection(name: "NW", angle: 315),
        ]
    }()
}




