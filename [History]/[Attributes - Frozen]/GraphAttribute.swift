//
//  GraphAttribute.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 6/2/25.
//

import Foundation

public struct GraphAttribute {
    public let jiggleIndex: Int
    public let graphIndex: Int
    public let grabAttributeType: GraphAttributeType
    public let grabAttributeTypeWithData: GraphAttributeTypeWithData
    public init(jiggleIndex: Int,
                graphIndex: Int,
                grabAttributeType: GraphAttributeType,
                grabAttributeTypeWithData: GraphAttributeTypeWithData) {
        self.jiggleIndex = jiggleIndex
        self.graphIndex = graphIndex
        self.grabAttributeType = grabAttributeType
        self.grabAttributeTypeWithData = grabAttributeTypeWithData
    }
}
