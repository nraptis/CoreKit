//
//  GrabAttribute.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public struct GrabAttribute {
    public let jiggleIndex: Int
    public let grabAttributeType: GrabAttributeType
    public let grabAttributeTypeWithData: GrabAttributeTypeWithData
    public init(jiggleIndex: Int,
                grabAttributeType: GrabAttributeType,
                grabAttributeTypeWithData: GrabAttributeTypeWithData) {
        self.jiggleIndex = jiggleIndex
        self.grabAttributeType = grabAttributeType
        self.grabAttributeTypeWithData = grabAttributeTypeWithData
    }
}

