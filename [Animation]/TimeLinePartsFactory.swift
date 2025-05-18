//
//  TimeLinePartsFactory.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/10/25.
//

import Foundation

public class TimeLinePartsFactory {
    
    public nonisolated(unsafe) static let shared = TimeLinePartsFactory()
    
    private init() {
        
    }
    
    @MainActor public func dispose() {
        precomputedLineSegments.removeAll(keepingCapacity: false)
        precomputedLineSegmentCount = 0
    }
    
    private var precomputedLineSegments = [AnyPrecomputedLineSegment]()
    var precomputedLineSegmentCount = 0
    func depositPrecomputedLineSegment(_ precomputedLineSegment: AnyPrecomputedLineSegment) {
        while precomputedLineSegments.count <= precomputedLineSegmentCount {
            precomputedLineSegments.append(precomputedLineSegment)
        }
        precomputedLineSegments[precomputedLineSegmentCount] = precomputedLineSegment
        precomputedLineSegmentCount += 1
    }
    func withdrawPrecomputedLineSegment() -> AnyPrecomputedLineSegment {
        if precomputedLineSegmentCount > 0 {
            precomputedLineSegmentCount -= 1
            return precomputedLineSegments[precomputedLineSegmentCount]
        }
        return AnyPrecomputedLineSegment()
    }
    
}
