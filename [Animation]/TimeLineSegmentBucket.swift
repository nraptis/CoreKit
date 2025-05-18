//
//  TimeLineSegmentBucket.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 9/18/24.
//

import Foundation

class TimeLineSegmentBucket {
    
    let startX: Float
    let endX: Float
    init(startX: Float, endX: Float) {
        self.startX = startX
        self.endX = endX
    }
    
    var precomputedLineSegments = [AnyPrecomputedLineSegment]()
    var precomputedLineSegmentCount = 0
    func add(_ precomputedLineSegment: AnyPrecomputedLineSegment) {
        while precomputedLineSegments.count <= precomputedLineSegmentCount {
            precomputedLineSegments.append(precomputedLineSegment)
        }
        precomputedLineSegments[precomputedLineSegmentCount] = precomputedLineSegment
        precomputedLineSegmentCount += 1
    }
    
    func removeAll() {
        precomputedLineSegmentCount = 0
    }
    
}
