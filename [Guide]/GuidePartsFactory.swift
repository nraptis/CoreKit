//
//  GuidePartsFactory.swift
//  Guide3
//
//  Created by Nicholas Raptis on 5/9/25.
//

import Foundation

public class GuidePartsFactory {
    
    public nonisolated(unsafe) static let shared = GuidePartsFactory()
    
    private init() {
        
    }
    
    public func dispose() {
        guidePoints.removeAll(keepingCapacity: false)
        guidePointCount = 0
        
        guidePoints.removeAll(keepingCapacity: false)
        guidePointCount = 0
        
        guideWeightPoints.removeAll(keepingCapacity: false)
        guideWeightPointCount = 0
        
        guideWeightSegments.removeAll(keepingCapacity: false)
        guideWeightSegmentCount = 0
        
        precomputedLineSegments.removeAll(keepingCapacity: false)
        precomputedLineSegmentCount = 0
    }
    
    ////////////////
    ///
    ///
    private var guidePoints = [GuidePoint]()
    var guidePointCount = 0
    public func depositGuidePoint(_ guidePoint: GuidePoint) {
        while guidePoints.count <= guidePointCount {
            guidePoints.append(guidePoint)
        }
        
        guidePoint.isManualTanHandleEnabledIn = false
        guidePoint.isManualTanHandleEnabledOut = false
        guidePoint.isTanHandleModified = false
        
        guidePoints[guidePointCount] = guidePoint
        guidePointCount += 1
    }
    
    public func withdrawGuidePoint() -> GuidePoint {
        if guidePointCount > 0 {
            guidePointCount -= 1
            let result = guidePoints[guidePointCount]
            
            return result
        }
        return GuidePoint()
    }
    ///
    ///
    ////////////////
    
    ////////////////
    ///
    ///
    private var guideWeightPoints = [GuideWeightPoint]()
    var guideWeightPointCount = 0
    public func depositGuideWeightPoint(_ guideWeightPoint: GuideWeightPoint) {
        while guideWeightPoints.count <= guideWeightPointCount {
            guideWeightPoints.append(guideWeightPoint)
        }
        guideWeightPoints[guideWeightPointCount] = guideWeightPoint
        guideWeightPointCount += 1
    }
    public func withdrawGuideWeightPoint() -> GuideWeightPoint {
        if guideWeightPointCount > 0 {
            guideWeightPointCount -= 1
            return guideWeightPoints[guideWeightPointCount]
        }
        return GuideWeightPoint()
    }
    ///
    ///
    ////////////////
    
    
    ////////////////
    ///
    ///
    private var guideWeightSegments = [GuideWeightSegment]()
    var guideWeightSegmentCount = 0
    public func depositGuideWeightSegment(_ guideWeightSegment: GuideWeightSegment) {
        guideWeightSegment.isIllegal = false
        while guideWeightSegments.count <= guideWeightSegmentCount {
            guideWeightSegments.append(guideWeightSegment)
        }
        guideWeightSegments[guideWeightSegmentCount] = guideWeightSegment
        guideWeightSegmentCount += 1
    }
    public func withdrawGuideWeightSegment() -> GuideWeightSegment {
        if guideWeightSegmentCount > 0 {
            guideWeightSegmentCount -= 1
            return guideWeightSegments[guideWeightSegmentCount]
        }
        return GuideWeightSegment()
    }
    ///
    ///
    ////////////////
    
    
    ////////////////
    ///
    ///
    private var precomputedLineSegments = [AnyPrecomputedLineSegment]()
    var precomputedLineSegmentCount = 0
    public func depositPrecomputedLineSegment(_ precomputedLineSegment: AnyPrecomputedLineSegment) {
        while precomputedLineSegments.count <= precomputedLineSegmentCount {
            precomputedLineSegments.append(precomputedLineSegment)
        }
        precomputedLineSegments[precomputedLineSegmentCount] = precomputedLineSegment
        precomputedLineSegmentCount += 1
    }
    public func withdrawPrecomputedLineSegment() -> AnyPrecomputedLineSegment {
        if precomputedLineSegmentCount > 0 {
            precomputedLineSegmentCount -= 1
            return precomputedLineSegments[precomputedLineSegmentCount]
        }
        return AnyPrecomputedLineSegment()
    }
    ///
    ///
    ////////////////

    
    ////////////////
    ///
    ///
    private var directedWeightPoints = [DirectedWeightPoint]()
    var directedWeightPointCount = 0
    public func depositDirectedWeightPoint(_ directedWeightPoint: DirectedWeightPoint) {
        while directedWeightPoints.count <= directedWeightPointCount {
            directedWeightPoints.append(directedWeightPoint)
        }
        
        directedWeightPoint.isManualTanHandleEnabledIn = false
        directedWeightPoint.isManualTanHandleEnabledOut = false
        
        directedWeightPoints[directedWeightPointCount] = directedWeightPoint
        directedWeightPointCount += 1
    }
    public func withdrawDirectedWeightPoint() -> DirectedWeightPoint {
        if directedWeightPointCount > 0 {
            directedWeightPointCount -= 1
            return directedWeightPoints[directedWeightPointCount]
        }
        return DirectedWeightPoint()
    }
    ///
    ///
    ////////////////
    
}
