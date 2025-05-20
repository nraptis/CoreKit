//
//  ContinuousAttributeDataUserRotationGroup.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public struct ContinuousAttributeDataUserRotationGroup {
    public let swoop: Float
    public let startRotation: Float
    public let endRotation: Float
    public init(swoop: Float, startRotation: Float, endRotation: Float) {
        self.swoop = swoop
        self.startRotation = startRotation
        self.endRotation = endRotation
    }
}
