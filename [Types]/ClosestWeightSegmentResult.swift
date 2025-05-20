//
//  ClosestWeightSegmentResult.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 5/18/25.
//

import Foundation

@frozen public enum ClosestWeightSegmentResult {
    case none
    case valid(JiggleWeightSegment, Float) // distance squared
}
