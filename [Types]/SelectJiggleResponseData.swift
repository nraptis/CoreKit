//
//  SelectJiggleResponseData.swift
//  TypeKit
//
//  Created by Nicholas Raptis on 5/10/25.
//

import Foundation

public struct SelectJiggleResponseData {
    public let jiggleIndex: Int
    public let pointIndex: Int
    public init(jiggleIndex: Int, pointIndex: Int) {
        self.jiggleIndex = jiggleIndex
        self.pointIndex = pointIndex
    }
}
