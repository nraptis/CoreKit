//
//  JiggleWeightPoint.swift
//  JiggleKit
//
//  Created by Nicholas Raptis on 5/15/25.
//

import Foundation

public class JiggleWeightPoint: PointProtocol {
    public var x = Float(0.0)
    public var y = Float(0.0)
    public var controlIndex = 0
    public var point: Math.Point {
        Math.Point(x: x, y: y)
    }
    public init(x: Float, y: Float) {
        self.x = x
        self.y = y
    }
    public init() {
        
    }
    
}
