//
//  GrabAttributeDataUserAll.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 6/8/25.
//

import Foundation

public struct GrabAttributeDataUserAll {
    
    public let dragPower: Float
    public let speed: Float
    public let stiffness: Float
    public let gyroPower: Float
    public init(dragPower: Float,
                speed: Float,
                stiffness: Float,
                gyroPower: Float) {
        self.dragPower = dragPower
        self.speed = speed
        self.stiffness = stiffness
        self.gyroPower = gyroPower
    }
}
