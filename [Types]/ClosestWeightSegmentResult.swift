//
//  ClosestJiggleWeightSegmentResult.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 5/18/25.
//

import Foundation

@frozen public enum ClosestJiggleWeightSegmentResult {
    case none
    case valid(JiggleWeightSegment, Float) // distance squared
}

@frozen public enum ClosestGuideWeightSegmentResult {
    case none
    case valid(GuideWeightSegment, Float) // distance squared
}
