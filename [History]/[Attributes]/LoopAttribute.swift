//
//  LoopAttribute.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public struct LoopAttribute {
    public let jiggleIndex: Int
    public let loopAttributeType: LoopAttributeType
    public let loopAttributeTypeWithData: LoopAttributeTypeWithData
    public init(jiggleIndex: Int, loopAttributeType: LoopAttributeType, loopAttributeTypeWithData: LoopAttributeTypeWithData) {
        self.jiggleIndex = jiggleIndex
        self.loopAttributeType = loopAttributeType
        self.loopAttributeTypeWithData = loopAttributeTypeWithData
    }
}
