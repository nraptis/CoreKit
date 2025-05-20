//
//  ContinuousAttribute.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public struct ContinuousAttribute {
    public let jiggleIndex: Int
    public let continuousAttributeType: ContinuousAttributeType
    public let continuousAttributeTypeWithData: ContinuousAttributeTypeWithData
    public init(jiggleIndex: Int, continuousAttributeType: ContinuousAttributeType, continuousAttributeTypeWithData: ContinuousAttributeTypeWithData) {
        self.jiggleIndex = jiggleIndex
        self.continuousAttributeType = continuousAttributeType
        self.continuousAttributeTypeWithData = continuousAttributeTypeWithData
    }
}
