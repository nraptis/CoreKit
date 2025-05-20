//
//  InsertLocation.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 5/19/25.
//

import Foundation

public struct InsertLocation {
    public let index: Int
    public let point: Math.Point
    public init(index: Int, point: Math.Point) {
        self.index = index
        self.point = point
    }
}
